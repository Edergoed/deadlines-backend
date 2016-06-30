class DeadlineEditor < ActiveRecord::Base
    has_many :deadlines
    has_many :users
end
