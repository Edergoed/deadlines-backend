class Role < ActiveRecord::Base
    has_and_belongs_to_many :perms
    belongs_to :users
end
