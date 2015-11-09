class Api::V1::TimetableController < ApplicationController
    require 'open-uri'
    # before_action :authenticate
    respond_to :json

    def index
        usertype = params[:usertype] #"/student"
        klass = params[:klass] #"/7P00035"
        file = open('http://lesroostersgames.hku.nl/'+ usertype + '/' + klass +'.htm')
        # file = open('http://lesroostersgames.hku.nl/student/7P00035.htm')
        contents = file.read.to_s
        # respond_with contents
        render json: { rooster: contents}, status: 201
    end
end
