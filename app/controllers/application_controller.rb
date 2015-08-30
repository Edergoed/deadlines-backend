class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :html, :json
  protect_from_forgery with: :null_session
  #include Authenticable
   protected

    ##
    # This method can be used as a before filter to protect
    # any actions by ensuring the request is transmitting a
    # valid JWT.
    def verify_jwt_token
      head :unauthorized if request.headers['Authorization'].nil? ||
          !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
    end
end