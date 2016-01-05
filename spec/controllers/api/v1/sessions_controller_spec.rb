require 'spec_helper'
require 'digest/md5'

# api_authorization_header AuthToken.issue_token({ id: user.id, firstname: user.firstname, lastname: user.lastname, email: user.email })

describe Api::V1::SessionsController do

	describe "POST #create" do

		before(:each) do
			@user = FactoryGirl.create :user
            gravatarHash = Digest::MD5.hexdigest(@user.email)
			api_authorization_header AuthToken.issue_token({ id: @user.id, firstname: @user.firstname, lastname: @user.lastname, email: @user.email, gravatar: gravatarHash })
		end

		context "when the credentials are correct" do

			before(:each) do
				credentials = { email: @user.email, password: "12345678" }
				#post :create, { session: credentials }
				post :create, { email: @user.email, password: "12345678" }

			end

			it "returns the user record corresponding to the given credentials" do
				#@user.reload
                sessions_response = json_response
            gravatarHash = Digest::MD5.hexdigest(@user.email)
				expect(sessions_response[:token]).to eql api_authorization_header AuthToken.issue_token({ id: @user.id, firstname: @user.firstname, lastname: @user.lastname, email: @user.email, gravatar: gravatarHash})
			end

			it { should respond_with 200 }
		end

		context "when the credentials are incorrect" do

			before(:each) do
				credentials = { email: @user.email, password: "invalidpassword" }
				post :create, { session: credentials }
			end

			it "returns a json with an error" do
				expect(json_response[:errors]).to eql "Invalid email or password"
			end

			it { should respond_with 422 }
		end
	end

	describe "DELETE #destroy" do

		before(:each) do
			@user = FactoryGirl.create :user
			sign_in @user
			delete :destroy, id: @user.auth_token
		end

		it { should respond_with 204 }

	end
end
