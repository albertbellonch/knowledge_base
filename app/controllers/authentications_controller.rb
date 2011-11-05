# -*- encoding: utf-8 -*-
class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Has entrat correctament"
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Autenticació externa associada"
      redirect_to edit_user_registration_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
       flash[:notice] = "Has entrat correctament"
        sign_in_and_redirect(:user, authentication.user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Autenticació externa desassociada"
    redirect_to edit_user_registration_url
  end
end
