class Assignment < ActiveRecord::Base
    belongs_to :deadline
    belongs_to :klass
end
