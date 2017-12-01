class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :update_email, :change_password]
  before_action :set_addresses, only: :edit

  def edit
  end

  def update_email
    if @user.update(user_params)
      redirect_to settings_edit_path(tab: 'privacy'),
                  notice: t('.success')
    else
      redirect_to settings_edit_path(tab: 'privacy'),
                  alert: t('.fail')
    end
  end

  def change_password
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to settings_edit_path(tab: 'privacy'),
                  notice: t('.success')
    else
      redirect_to settings_edit_path(tab: 'privacy'),
                  alert: t('fail')
    end
  end

  def update
    if params[:billing_address]
      address = Forms::BillingAddressForm.from_params(params[:billing_address])
    elsif params[:shipping_address]
      address = Forms::ShippingAddressForm.from_params(params[:shipping_address])
                .with_context(use_billing_address_as_shipping: false)
    end
    if address.valid?
      addr = Address.find_or_create_by(user_id: @user.id, type: address.type)
      addr.update_attributes(address.attributes)
      redirect_to settings_edit_path, notice: t('.success')
    else
      redirect_to settings_edit_path(settings_params),
                  alert: t('.fail')
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email, :current_password,
                                    :password, :password_confirmation)
    end

    def settings_params
      params.permit(billing_address: [:first_name, :last_name, :address, :city,
                                      :zip, :country, :phone],
                    shipping_address: [:first_name, :last_name, :address, :city,
                                      :zip, :country, :phone])
    end

    def set_addresses
      if params[:billing_address]
        @billing_address = Forms::BillingAddressForm.from_params(params[:billing_address])
        @billing_address.valid?
      else
        @billing_address = Forms::BillingAddressForm.from_model(@user.billing_address)
      end

      if params[:shipping_address]
        @shipping_address = Forms::ShippingAddressForm.from_params(params[:shipping_address])
                            .with_context(use_billing_address_as_shipping: false)
        @shipping_address.valid?
      else
        @shipping_address = Forms::ShippingAddressForm.from_model(@user.shipping_address)
      end
    end
end
