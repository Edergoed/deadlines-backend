class Api::V1::DeadlinesController < ApplicationController
    #before_action :verify_jwt_token, only: [:create, :update, :destroy]
    before_action :authenticate
    respond_to :json

    def index
        deadlines = Deadline.all.where(['deadlineDateTime >= ? AND klass = ?', Time.new, @current_user.klass]).order('deadlineDateTime ASC')
        respond_with deadlines
    end
    
    def test
        respond_with Deadline.search(params)
    end

    def archive
        deadlines = Deadline.all.where(['deadlineDateTime < ? AND klass = ?', Time.new, @current_user.klass]).order('deadlineDateTime DESC')
        respond_with deadlines
    end

    def show
        respond_with Deadline.find(params[:id])
    end

    def create
        deadline = Deadline.new(deadline_params.merge(creator_id: @current_user.id, klass: @current_user.klass))
        if deadline.save
            render json: deadline, status: 201, location: [:api, deadline]
        else
            render json: { errors: deadline.errors}, status: 422
        end
    end

    def update

        deadline = Deadline.find(params[:id])
        if deadline.update(deadline_params.merge(editor_id: @current_user.id))
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
        params.require(:deadline).permit(:title, :subject, :deadlineDateTime, :klass, :group_id, :content, :published)
    end
end
