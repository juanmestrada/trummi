Rails.application.routes.draw do

	# root :to => 'dashboard#welcome'

	devise_scope :user do
	  root :to => 'dashboard#welcome'
	end

	devise_for :users
	resources :users, except: [:index] do
		member do
			get :following, :followers
		end
		member do
			get :blocking, :blockers
		end
	end
	
	get :welcome, controller: :dashboard

	resources :posts, except: [:edit] do 
		# resources :comments, only: [:new, :create, :destroy]

		resources :comments do
			member do
				get :remove
			end
		end	

		member do 
			post 'crying_reaction'
		end
		member do 
			post 'tea_reaction'
		end
		member do 
			post 'tellmemore_reaction'
		end
		member do 
			post 'what_reaction'
		end
		member do 
			post 'disapproval_reaction'
		end
		member do 
			post 'excited_reaction'
		end
		member do 
			post 'entertained_reaction'
		end
		member do 
			post 'fightme_reaction'
		end
		member do 
			post 'dafuq_reaction'
		end
		member do 
			post 'proud_reaction'
		end
		member do 
			post 'mad_reaction'
		end
		member do 
			post 'clapping_reaction'
		end
		member do 
			post 'unsure_reaction'
		end
		member do 
			post 'laughing_reaction'
		end
		member do 
			post 'thatsracist_reaction'
		end
		member do 
			post 'thinkaboutit_reaction'
		end
		member do 
			post 'wtf_reaction'
		end
		member do 
			post 'crying2_reaction'
		end

		member do 
			post 'like'
		end

		member do
		    get :remove
		end
		
	end

	resources :profiles, path: :profile, except: [:index] do
		
		member do 
			post 'private'
		end
		member do 
			post 'private_tags'
		end
		member do
			get :media
		end
		member do
			get :followers
		end
		member do
			get :following
		end
		
	end

	resources :tags, except: [:edit] do 
		# collection do
		# 	get "/matches" => 'tags#index'
		# end
		member do
			get :remove
		end
	end
	
	resources :user_tags, only: [:new, :create, :destroy]

	get '/settings/blocked' => 'settings#blocked'
	get '/settings/disable_account' => 'settings#disable_account'
	get '/settings/delete_account' => 'settings#delete_account'
	get '/settings/remove' => 'settings#remove'

	resources :settings, only: [:index]

	get '/help' => 'help#help'
	get '/help/account' => 'help#account'
	get '/help/about' => 'help#about'
	get '/help/matches' => 'help#matches'
	get '/help/messaging' => 'help#messaging'
	get '/help/tags' => 'help#tags'
	get '/help/verification' => 'help#verification'

	resources :personal_messages, only: [:new, :create]
	resources :conversations, only: [:index, :show, :destroy] do
		member do
			get :remove
		end
	end
	# resources :friendships, only: [:show, :create, :destroy]
	resources :relationships, path: :following
	resources :blocks do
		member do
			get :remove
		end
	end

	resources :messages, only: [:new, :create, :destroy]

	resource :dashboard do
		collection do
			post :search, to: 'dashboard#search'
		end
	end

	resources :notifications do 
		collection do
			post :mark_as_read
		end
	end

	get :matches, action: :index, controller: :tags
	get :search, controller: :tags
	get :interstitial, action: :screen, controller: :interstitials
	# mount ActionCable.server => '/cable'
	
	get '*path' => redirect('/')
	
end
