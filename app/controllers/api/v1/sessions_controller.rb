class Api::V1::SessionsController < ApplicationController

    require 'auth_token'
    require 'digest/md5'
    respond_to :json

    def create
        user_password = params[:session][:password]
        user_email = params[:session][:email]
        user = user_email.present? && User.find_by(email: user_email)

        if user != nil
            if user.valid_password? user_password
                if user.active
                    gravatarHash = Digest::MD5.hexdigest(user.email)
                    permissions = []
                    if(user.prefix == nil)
                    token = AuthToken.issue_token({ id: user.id, firstname: user.firstname, lastname: user.lastname, email: user.email, gravatar: gravatarHash })
                    else
                    token = AuthToken.issue_token({ id: user.id, firstname: user.firstname, prefix: user.prefix, lastname: user.lastname, email: user.email, gravatar: gravatarHash })
                    end
                    render json: { token: token}, status: 200, location: [:api, user]
                else
                    render json: { errors: "Acount is disabled" }, status: 422
                end
            else
                render json: { errors: "Invalid email or password" }, status: 422
            end
        else
            render json: { errors: "Invalid email or password, user nill" }, status: 422
        end
    end

    def destroy
        user = User.find_by_id(params[:id])
        user.generate_authentication_token!
        user.save
        head 204
    end
end
