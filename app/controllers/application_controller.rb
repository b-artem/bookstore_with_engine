class ApplicationController < ActionController::Base
  include CurrentCart
  protect_from_forgery with: :exception
  before_action :set_locale_from_params
  before_action :store_user_location, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart
  before_action :load_categories

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def set_locale_from_params
    return unless params[:locale]
    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = t('application.translation_not_available',
                             locale: params[:locale])
      logger.error flash.now[:notice]
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session)
  end

  def load_categories
    @categories = Category.all
  end

  private

    def storable_location?
      request.get? && !devise_controller? && !request.xhr?
    end

    def store_user_location
      store_location_for(:user, request.fullpath)
    end
end
