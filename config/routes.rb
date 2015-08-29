require 'api_constraints'

ApiDeadlines::Application.routes.draw do
	mount SabisuRails::Engine => "/sabisu_rails"
	#devise_for :users
	# Api definition
	namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
		scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
			resources :users, :only => [:show, :create, :update, :destroy] do
				resources :deadlines, :only => [:create, :update, :destroy]
			end
			resources :sessions, :only => [:create, :destroy]
			resources :deadlines, :only => [:show, :index]
		end
	end
	#devise_for :users, controllers: {sessions: 'api/v1/sessions', registrations: 'api/v1/registrations'}
	
end
