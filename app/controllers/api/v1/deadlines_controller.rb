class Api::V1::DeadlinesController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :update, :destroy]
	respond_to :json

	def index
		deadlines = params[:deadline_ids].present? ? Deadline.find(params[:deadline_ids]) : Deadline.all
		respond_with deadlines
	end

	def show
		respond_with Deadline.find(params[:id])   
	end

	def create
		#this fixes a lot
		deadline = Deadline.new(deadline_params.merge(creator_id: current_user.id))
		# deadline = current_user.deadlines.build(deadline_params) 
		if deadline.save
			render json: deadline, status: 201, location: [:api, deadline] 
		else
			render json: { errors: deadline.errors }, status: 422
		end
	end

	def update
		# deadline = current_user.deadlines.find(params[:id])
		# deadline = deadlines.find(params[:id])
		deadline = Deadline.find(params[:id])
		if deadline.update(deadline_params.merge(editor_id: current_user.id))
			render json: deadline, status: 200, location: [:api, deadline]
		else
			render json: { errors: deadline.errors }, status: 422
		end
	end

	def destroy
		# deadline = current_user.deadlines.find(params[:id]) 
		deadline = Deadline.find(params[:id])
		deadline.destroy
		head 204
	end

	private

	def deadline_params
		params.require(:deadline).permit(:title, :price, :published)
	end
	def deadline_create_params
		params.require(:deadline).permit(:title, :price, :published, :creator_id).merge(creator_id: current_user.id)
	end

end