class Api::V1::TimetableController < ApplicationController
    require 'open-uri'
    # before_action :authenticate
    respond_to :json

    def index
        usertype = params[:usertype] #"/student"
        klass = params[:klass] #"/7P00035"
        file = open('http://lesroostersgames.hku.nl/'+ usertype + '/' + klass +'.htm')
        list_student = open('http://lesroostersgames.hku.nl/student/').read.to_s
        list_docent = open('http://lesroostersgames.hku.nl/docent/').read.to_s
        # file = open('http://lesroostersgames.hku.nl/student/7P00035.htm')
        contents = file.read.to_s
        # respond_with contents
        render json: { rooster: contents, docent: list_docent, student: list_student}, status: 201
    end
end
