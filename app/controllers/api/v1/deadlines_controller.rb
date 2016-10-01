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

    def latest
        #deadlines = Deadline.all.where(['deadlineDateTime >= ? AND klass = ?', Time.new, @current_user.klass]).order('deadlineDateTime ASC')
        deadlines = Deadline.joins(:klasses).all.where(['deadlineDateTime >= ? AND klass_id = ?', Time.new, @current_user.klass]).order('deadlineDateTime ASC Limit 1')
        respond_with deadlines
    end

    def lastarchive
        #deadlines = Deadline.all.where(['deadlineDateTime >= ? AND klass = ?', Time.new, @current_user.klass]).order('deadlineDateTime ASC')
        deadlines = Deadline.joins(:klasses).all.where(['deadlineDateTime < ? AND klass_id = ?', Time.new, @current_user.klass]).order('deadlineDateTime DESC Limit 1')
        respond_with deadlines
    end

    def show
        respond_with Deadline.find(params[:id])
    end

    def create
        deadline = Deadline.new(deadline_params.merge(creator_id: @current_user.id))

        #klass = Klass.find(@current_user.klass)
        #Deadline.klasses << k
        # klasses = Klass.select(:id).where(id: params[:klass_ids])
        if deadline.save
            render json: {Message: "Added new deadline succesfully" }, status: 201, location: [:api, deadline]
        else
            render json: { errors: deadline.errors}, status: 422
        end
        # params(:klass_ids).each do |assingment|
        #     #parent.children.create (:child_name => 'abc')
        #     deadline.assignments.create(klass_id: assingment);
        # end

        deadline.klasses << Klass.select(:id).where(id: params[:klass_ids])
        # deadline.assignments.create(klass_id: params[:klasses]);
        #deadline.assignments.create(klass: klass)

    end

    def update
        deadline = Deadline.find(params[:id])
        editor = User.find(@current_user.id)
        unselectedKlasses = Assignment.select(:id).where(deadline_id: deadline['id']).where.not(klass_id: params[:klass_ids]).collect(&:id)
        assignments = Assignment.all.where(deadline_id: params[:id])

        deadline.update(deadline_params)
        if deadline.update(deadline_params)
            render json: {Message: "Updated deadline succesfully"}, status: 200, location: [:api, deadline]
        else
            render json: { errors: deadline.errors }, status: 422
        end
        deadline.deadline_edits.create(editor: editor)

        Assignment.delete(unselectedKlasses);

        for klass in params[:klass_ids]
            bool = true
            for assignment in assignments
                if klass == assignment['klass_id']
                    bool = false
                end
            end
            if bool
                deadline.klasses << Klass.find(klass)
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
        #params.permit(:klass_ids => [])
        params.require(:deadline).permit(:klass_ids => [])
        params.require(:deadline).permit(:title, :subject, :deadlineDateTime, :group_id, :content, :published, )
    end
end
