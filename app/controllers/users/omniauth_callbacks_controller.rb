class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    unless request.env["omniauth.auth"].info.email
      flash[:warning] = t '.no_email_provided'
    end
    sign_in_and_redirect @user
  end

  def failure
    flash[:warning] = t '.failed_to_sign_in'
    redirect_to root_path
  end
end
