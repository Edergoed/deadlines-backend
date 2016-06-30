class User < ActiveRecord::Base
	#validates :auth_token, uniqueness: true
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable


	#before_create :generate_authentication_token!

	#has_many :deadlines, dependent: :destroy

	has_many :created_deadlines,  :foreign_key=>"creator_id", :class_name => "Deadline"
    has_many :deadline_edits, foreign_key: 'editor_id'
    has_many :edited_deadlines, through: :deadline_edits, source: :deadline

	has_many :perms, :through => :roles
end
