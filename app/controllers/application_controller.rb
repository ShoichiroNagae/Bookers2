class ApplicationController < ActionController::Base
  # アプリ完成2 7章
  before_action :authenticate_user!, except: [:top ,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインイン後、又はサインアウト後に遷移するパスを指定
  # サインイン後はログインしたユーザーの詳細ページへ
  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    user_path(current_user.id)
  end

  # ログアウト後はルートパスへ遷移
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
