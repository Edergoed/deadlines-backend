class Api::V1::SessionsController < ApplicationController

  require 'auth_token'
  require 'digest/md5'
  respond_to :json

  def create 
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email) 

    if user.valid_password? user_password
      hash = Digest::MD5.hexdigest(user.email)
      gravatarUrl = "http://www.gravatar.com/avatar/#{hash}"
      token = AuthToken.issue_token({ id: user.id, email: user.email, role: user.role, gravatar: gravatarUrl })
      render json: {:token => token}, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end 
  end

  def destroy
    user = User.find_by_id(params[:id])    
    user.generate_authentication_token!
    user.save
    head 204
  end
end