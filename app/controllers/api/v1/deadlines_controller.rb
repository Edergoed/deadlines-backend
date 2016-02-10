class Api::V1::DeadlinesController < ApplicationController
    #before_action :verify_jwt_token, only: [:create, :update, :destroy]
    before_action :authenticate
    respond_to :json

    def index
        #deadlines = Deadline.all.where(['deadlineDateTime >= ? AND klass = ?', Time.new, @current_user.klass]).order('deadlineDateTime ASC')
        deadlines = Deadline.joins(:klasses).all.where(['deadlineDateTime >= ? AND klass_id = ?', Time.new, @current_user.klass]).order('deadlineDateTime ASC')
        respond_with deadlines
    end

    def test
        respond_with Deadline.search(params)
    end

    def archive
        deadlines = Deadline.joins(:klasses).all.where(['deadlineDateTime < ? AND klass_id = ?', Time.new, @current_user.klass]).order('deadlineDateTime DESC')
        respond_with deadlines
    end

    def show
        respond_with Deadline.find(params[:id])
    end

    def create
        deadline = Deadline.new(deadline_params.merge(creator_id: @current_user.id))
        klass = Klass.find(@current_user.klass)
        #Deadline.klasses << k
        if deadline.save
            render json: deadline, status: 201, location: [:api, deadline]
        else
            render json: { errors: deadline.errors}, status: 422
        end
        deadline.assignments.create(klass: klass)
    end

    def update

        deadline = Deadline.find(params[:id])
        editor = User.find(@current_user.id)
        klasses = Klass.select(:id).where(id: params[:klass_ids])
        allKlasses = Klass.where.not(id: params[:klass_ids])
        assignments = Assignment.all.where(deadline_id: params[:id])
        if deadline.update(deadline_params)
            render json: {jaja: klasses}, status: 200, location: [:api, deadline]
        else
            render json: { errors: deadline.errors }, status: 422
        end
        deadline.deadline_edits.create(editor: editor)

        #assingments.each do | assignment |
        #klasses.each do | klass |
        for assignment in assignments
            for klass in allKlasses
                if assignment['klass_id'] != klass
                    assignment.destroy
                end
            end
        end

        for klass in klasses
                if assignment['klass_id'] != klass
                    deadline.assignments.create(klass: Klass.find(klass))
                end
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
        params.permit(:klass_ids => [])
        params.require(:deadline).permit(:title, :subject, :deadlineDateTime, :group_id, :content, :published)
    end
end
