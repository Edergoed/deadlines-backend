require 'spec_helper'

describe Role do
	before { @role = FactoryGirl.build(:role) }

	subject { @role }

	it { should respond_to(:name) }

	it { should have_and_belong_to_many(:perms) }
end

