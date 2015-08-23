require 'spec_helper'

describe Deadline do
  let(:deadline) { FactoryGirl.build :deadline }
  subject { deadline }

  it { should respond_to(:title) }
  it { should respond_to(:subject) }
  it { should respond_to(:deadline) }
  it { should respond_to(:class_id) }
  it { should respond_to(:group_id) }
  it { should respond_to(:content) }
  it { should respond_to(:published) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:editor_id) }
  it { should respond_to(:creator) }
  it { should respond_to(:editor) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :deadline }
  it { should validate_presence_of :content }
  it { should validate_presence_of :creator_id }

  it { should belong_to :creator }
  it { should belong_to :editor }

end