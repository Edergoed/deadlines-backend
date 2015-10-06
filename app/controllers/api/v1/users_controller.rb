class Api::V1::UsersController < ApplicationController
	#before_action :authenticate_with_token!, only: [:update, :destroy]
	require 'securerandom'

	respond_to :json

	def show
		respond_with User.find(params[:id])
	end

	def create
		activation_token = SecureRandom.uuid

		user = User.new(user_params)
		if user.save
            UserNotifier.send_signup_email(user, activation_token).deliver
            AdminNotifier.send_newuser(user).deliver
			render json: user, status: 201, location: [:api, user]
		else
			render json: { errors: @user.errors }, status: 422
		end
	end

	def update
		user = current_user

		if user.update(user_params)
			render json: user, status: 200, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	def destroy
		current_user.destroy
		head 204
	end

	def activate
		#render json: { message: 'You just registers' }, status: 201

		user = User.find_by(activation_token: params[:activationToken])
		#render json: { errors: params[:activationToken] }, status: 201
		if user != nil
			if user.update(:active => 1, :activation_token => nil)
				render json: user, status: 200, location: [:api, user]
			else
				render json: { errors: user.errors }, status: 422
			end
		else
			render json: { errors: 'Wrong activation token' }, status: 201
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :klass)
	end
end
