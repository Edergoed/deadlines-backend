class Api::V1::DeadlinesController < ApplicationController
    #before_action :verify_jwt_token, only: [:create, :update, :destroy]
    before_action :authenticate
    respond_to :json

    def index
        #deadlines = Deadlines.find_by_sql('SELECT * FROM deadlines WHERE deadline >= :homeDate ORDER BY deadline ASC')
        #SELECT * FROM deadlines WHERE deadline_deadline >= :homeDate AND (deadline_class = :user_class OR deadline_group IN (SELECT group_id from groups_users WHERE user_id = :user_id)) ORDER BY deadline_deadline ASC'
        deadlines = params[:deadline_ids].present? ? Deadline.find(params[:deadline_ids]) : Deadline.all.where(['deadlineDateTime >= ? AND klass = ?', Time.new, User.find_by_id(@current_user).klass]).order('deadlineDateTime ASC')
        respond_with deadlines
        #render json: { errors: User.find_by_id(@current_user)}, status: 422
    end

    def archive
        deadlines = Deadline.all.where(['deadlineDateTime < ?', Time.new ]).order('deadlineDateTime DESC')
        respond_with deadlines
    end

    def show
        respond_with Deadline.find(params[:id])
    end

    def create
        #this fixes a lot
        deadline = Deadline.new(deadline_params.merge(creator_id: @current_user, editor_id: nil, klass: User.find_by_id(@current_user).klass))
        # deadline = current_user.deadlines.build(deadline_params)
        if deadline.save
            render json: deadline, status: 201, location: [:api, deadline]
        else
            render json: { errors: deadline.errors}, status: 422
        end
    end

    def update

        deadline = Deadline.find(params[:id])
        if deadline.update(deadline_params.merge(editor_id: @current_user))
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
