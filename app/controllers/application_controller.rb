# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    books_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal, :address, :introduction, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal, :address, :introduction, :avatar])
    end
end
