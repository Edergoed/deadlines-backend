require 'spec_helper'

describe Perm do
	before { @perm = FactoryGirl.build(:perm) }

	subject { @perm }

	it { should respond_to(:name) }

	it { should have_and_belong_to_many(:roles) }
end

