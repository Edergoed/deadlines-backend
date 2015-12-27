require 'spec_helper'

describe User do
	before { @user = FactoryGirl.build(:user) }

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:activation_token) }

	it { should be_valid }

	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	it { should allow_value('example@domain.com').for(:email) }
	#it { should validate_uniqueness_of(:activation_token)}

	it { should have_many(:created_deadlines) }
  it { should have_many(:edited_deadlines) }
	
describe "#generate_authentication_token!" do
#    it "generates a unique token" do
#      Devise.stub(:friendly_token).and_return("auniquetoken123")
#      @user.generate_authentication_token!
#      expect(@user.activation_token).to eql "auniquetoken123"
#    end

#    it "generates another token when one already has been taken" do
#      existing_user = FactoryGirl.create(:user, activation_token: "auniquetoken123")
#      @user.generate_authentication_token!
#      expect(@user.activation_token).not_to eql existing_user.activation_token
#    end

    it "destroys the associated deadlines on self destruct" do
      deadlines = @user.created_deadlines
      @user.destroy
      deadlines.each do |deadline|
        expect(Deadline.find(deadline)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end