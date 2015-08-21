require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.build :product }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:editor_id) }
  it { should respond_to(:creator) }
  it { should respond_to(:editor) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :creator_id }
  it { should validate_presence_of :editor_id }

  it { should belong_to :creator }
  it { should belong_to :editor }

end