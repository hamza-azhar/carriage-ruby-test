Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :create do
  	collection do
  		post :signin
      get :get_all_users
  	end
  end

  resources :lists, only: [:index, :show]
  resources :cards, only: [:index, :show, :create] do
    collection do
      post :update_card
      post :remove_card
    end
  end

  namespace :admin do
  	resources :lists, only: [:create, :index, :show] do
	  	collection do
        post :update_list
        post :destroy_list
	  		post :assign_member
	  		post :unassign_member
	  	end
	  end

	  resources :cards, only: [:create, :index, :show] do 
	  	collection do
        post :update_card
        post :destroy_card
	  	end
	  end
  end
end
