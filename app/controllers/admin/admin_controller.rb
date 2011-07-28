class Admin::AdminController < ApplicationController
  before_filter :require_admin
  layout 'backoffice'

  private

  def require_admin
    if !current_user
      redirect_to new_user_session_url, :notice => "Has d'entrar com a administrador"
    elsif !current_user.admin
      redirect_to root_url, :notice => "No tens permisos d'administrador"
    end
  end
end
