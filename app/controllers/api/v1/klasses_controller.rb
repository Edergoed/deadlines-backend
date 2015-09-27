class Api::V1::KlassesController < ApplicationController
	respond_to :json

	def index
        klasses = Klass.all
        respond_with klasses
    end
end
