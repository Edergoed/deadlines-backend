class Api::V1::DeadlinesController < ApplicationController
	before_action :verify_jwt_token, only: [:create, :update, :destroy]
	before_action :authenticate
	respond_to :json

	def index
		#deadlines = Deadlines.find_by_sql('SELECT * FROM deadlines WHERE deadline >= :homeDate ORDER BY deadline ASC')
		deadlines = params[:deadline_ids].present? ? Deadline.find(params[:deadline_ids]) : Deadline.all.where(['deadline >= ?', Time.new ]).order('deadline asc')
		respond_with deadlines
	end

	def show
		respond_with Deadline.find(params[:id])
	end

	def create

		
		begin
			time = Time.parse(params[:time])
			
		rescue ArgumentError
			error = OpenStruct.new()
			error.time = 'invalid time format'
		end

		if error == nil
			hours = params[:time].split(":").first 
			minutes = params[:time].split(":").last
			deadlineTime = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, hours.to_i, minutes.to_i)
			#this fixes a lot
			deadline = Deadline.new(deadline_params.merge(creator_id: @current_user, deadline: deadlineTime))
			# deadline = current_user.deadlines.build(deadline_params)
			if deadline.save
				render json: { errors: deadline, plz: time }, status: 201, location: [:api, deadline]
			else
				render json: { errors: deadline.errors, plz: time }, status: 422
			end
		else
			render json: { errors: error }, status: 422
		end
	end

	def update
		# deadline = current_user.deadlines.find(params[:id])
		# deadline = deadlines.find(params[:id])
		hours = params[:time].split(":").first 
		minutes = params[:time].split(":").last
		deadlineTime = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, hours.to_i, minutes.to_i)

		deadline = Deadline.find(params[:id])
		if deadline.update(deadline_params.merge(editor_id: @current_user, deadline: deadlineTime))
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
		params.require(:deadline).permit(:title, :subject, :deadline, :class_id, :group_id, :content, :published)
	end
end
