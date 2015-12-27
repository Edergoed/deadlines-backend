require 'spec_helper'
require 'auth_token'
require 'digest/md5'

class Authentication
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new } 
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user

      gravatarHash = Digest::MD5.hexdigest(@user.email)
      request.headers["Authorization"] = AuthToken.issue_token({ id: @user.id, firstname: @user.firstname, lastname: @user.lastname, email: @user.email, gravatar: gravatarHash })
      authentication.stub(:request).and_return(request)
    end
    it "returns the user from the authorization header" do
      token = request.headers['Authorization'].split(' ').last
        payload, header = AuthToken.valid?(token)
        @current_user = User.find(payload['id'])
      expect(@current_user.email).to eql @user.email
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryGirl.create :user
      authentication.stub(:current_user).and_return(nil)
      response.stub(:response_code).and_return(401)
      response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      authentication.stub(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it {  should respond_with 401 }
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        authentication.stub(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        authentication.stub(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end
end
