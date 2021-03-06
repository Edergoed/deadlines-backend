require 'spec_helper'

describe Perm do
	before { @klass = FactoryGirl.build(:klass) }

	subject { @klass }

	it { should respond_to(:name) }

	it { should have_and_belong_to_many(:roles) }
end

