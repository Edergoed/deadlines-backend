require 'spec_helper'

describe Api::V1::DeadlinesController do

    describe "GET #show" do
        before(:each) do 
            @deadline = FactoryGirl.create :deadline
            get :show, id: @deadline.id
        end

        it "returns the information about a reporter on a hash" do
            deadline_response = json_response[:deadline]
            expect(deadline_response[:title]).to eql @deadline.title
        end

        it "has the user as a embeded object" do
            deadline_response = json_response[:deadline]
            # include_json(results: { 2 => { id: 27, badges: ["day & night"] }})
            expect(deadline_response[:creator][:email]).to eql @deadline.creator.email
        end

        it { should respond_with 200 }
    end

    describe "GET #index" do
        before(:each) do
            4.times { FactoryGirl.create :deadline } 
        end

        context "when is not receiving any deadline_ids parameter" do
            before(:each) do
                get :index
            end

            it "returns 4 records from the database" do
                deadlines_response = json_response
                expect(deadlines_response[:deadlines].length).to eq(4)
            end

            it "returns the user object into each deadline" do
                deadlines_response = json_response[:deadlines]
                deadlines_response.each do |deadline_response|
                    expect(deadline_response[:creator]).to be_present
                end
            end

            it { should respond_with 200 }
        end

        context "when deadline_ids parameter is sent" do
            before(:each) do
                @creator = FactoryGirl.create :creator
                3.times { FactoryGirl.create :deadline, creator: @creator }
                get :index, deadline_ids: @creator.created_deadline_ids
            end

            it "returns just the deadlines that belong to the user" do
                deadlines_response = json_response[:deadlines]
                deadlines_response.each do |deadline_response|
                    expect(deadline_response[:creator][:email]).to eql @creator.email
                end
            end
        end
    end

    describe "POST #create" do
        context "when is successfully created" do
            before(:each) do
                creator = FactoryGirl.create :creator
                @deadline_attributes = FactoryGirl.attributes_for :deadline
                api_authorization_header creator.auth_token 
                post :create, { user_id: creator.id, deadline: @deadline_attributes }
            end

            it "renders the json representation for the deadline record just created" do
                deadline_response = json_response[:deadline]
                expect(deadline_response[:title]).to eql @deadline_attributes[:title]
            end

            it { should respond_with 201 }
        end

        context "when is not created" do
            before(:each) do
                creator = FactoryGirl.create :creator 
                @invalid_deadline_attributes = { title: "Smart TV", price: "Twelve dollars" }
                api_authorization_header creator.auth_token 
                post :create, { user_id: creator.id, deadline: @invalid_deadline_attributes }
            end

            it "renders an errors json" do
                deadline_response = json_response
                expect(deadline_response).to have_key(:errors)
            end

            it "renders the json errors on whye the user could not be created" do
                deadline_response = json_response
                expect(deadline_response[:errors][:price]).to include "is not a number"
            end

            it { should respond_with 422 }
        end
    end

    describe "PUT/PATCH #update" do
        # before(:each) do
        #     @user = FactoryGirl.create :user
        #     @deadline = FactoryGirl.create :deadline, user: @user
        #     api_authorization_header @user.auth_token 
        # end
        before(:each) do
            @creator = FactoryGirl.create :creator
            @deadline = FactoryGirl.create :deadline, creator: @creator
            api_authorization_header @creator.auth_token 
        end

        context "when is successfully updated" do
            before(:each) do
                patch :update, { user_id: @creator.id, id: @deadline.id, deadline: { title: "An expensive TV" } }
            end

            it "renders the json representation for the updated user" do
                deadline_response = json_response[:deadline]
                expect(deadline_response[:title]).to eql "An expensive TV"
            end

            it { should respond_with 200 }
        end

        context "when is not updated" do
            before(:each) do
                patch :update, { user_id: @creator.id, id: @deadline.id, deadline: { price: "two hundred" } }
            end

            it "renders an errors json" do
                deadline_response = json_response
                expect(deadline_response).to have_key(:errors)
            end

            it "renders the json errors on whye the user could not be created" do
                deadline_response = json_response
                expect(deadline_response[:errors][:price]).to include "is not a number"
            end

            it { should respond_with 422 }
        end
    end

    describe "DELETE #destroy" do
        before(:each) do
            @creator = FactoryGirl.create :creator
            @deadline = FactoryGirl.create :deadline, creator: @creator
            api_authorization_header @creator.auth_token 
            delete :destroy, { user_id: @creator.id, id: @deadline.id }
        end

        it { should respond_with 204 }
    end

end