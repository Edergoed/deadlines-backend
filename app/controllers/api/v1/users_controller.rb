class Api::V1::UsersController < ApplicationController
    #before_action :authenticate_with_token!, only: [:update, :destroy]
    before_action :authenticate, only: [:update, :destroy]
    require 'securerandom'

    respond_to :json

    def show
        respond_with User.find(params[:id])
    end

    def create
        activation_token = SecureRandom.hex(16)

        user = User.new(user_params.merge(activation_token: activation_token))
        if user.save
            UserNotifier.send_signup_email(user, activation_token).deliver
            AdminNotifier.send_newuser(user).deliver
            render json: user, status: 201, location: [:api, user]
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def reset
        reset_token = SecureRandom.hex(16)

        user = User.new(user_params.merge(activation_token: reset_token))
        if user.save
            UserNotifier.send_reset_email(user, activation_token).deliver
            render json: user, status: 201, location: [:api, user]
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def update
        user = User.find(params[:id])

        if user.id == @current_user.id
            if user.update(user_params)
                render json: user, status: 200, location: [:api, user]
            else
                render json: { errors: user.errors }, status: 422
            end
        else
            render json: { errors: 'No permisson' }, status: 422
        end
    end

    def destroy
        @current_user.destroy
        head 204
    end

    def activate
        #render json: { message: 'You just registers' }, status: 201

        user = User.find_by(activation_token: params[:activationToken])
        #render json: { errors: params[:activationToken] }, status: 201
        if user != nil
            # gravatarHash = Digest::MD5.hexdigest(user.email)
            token = AuthToken.issue_token({ id: user.id, email: user.email, gravatar: gravatarHash })
            if user.update(:active => 1, :activation_token => nil)
                render json: {:token => token}, status: 200, location: [:api, user]
            else
                render json: { errors: user.errors }, status: 422
            end
        else
            render json: { errors: 'Invalid activation token' }, status: 422
        end
    end

    def restpass
        user = User.find_by(id: params[id])

        if user.reset_token === params[:reset_token]
            user = User.new(user_params)
            if user.update(:reset_token => nil)
                render json: { errors: 'Password is reset' }, status: 201
            else
                render json: { errors: 'Invalid activation token' }, status: 422
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :klass, :firstname, :lastname, :prefix)
    end
end
