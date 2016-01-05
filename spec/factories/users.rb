FactoryGirl.define do
	require 'securerandom'
	factory :user, :aliases => [:creator, :editor] do
		email { FFaker::Internet.email }
		password "12345678"
		password_confirmation "12345678"
		klass 1
        active 1
		activation_token { SecureRandom.hex(16) }

	end
end
