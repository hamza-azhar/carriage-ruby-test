Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :create do
  	collection do
  		post :signin
  	end
  end

  resources :lists, only: [:index, :show]

  namespace :admin do
  	resources :lists do
	  	collection do
	  		post :assign_member
	  		post :unassign_member
	  	end
	  end
  end
end
