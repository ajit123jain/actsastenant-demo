Rails.application.routes.draw do
  # root 'home#index'
  # get 'home/index'

  root 'home#index'

  devise_for :users

  resources :members do
    get :invite, on: :collection
    member do
      patch :resend_invitation
    end
  end

  resources :tenants do
    get :my, on: :collection
    member do
      patch :switch
    end
  end

  resources :users, only: [:index, :show]
  # constraints :subdomain => /dev|poplify/ do
  #   resources :posts
  # end
  
  constraints SubdomainConstraint do
    get 'dashboard/index'
    resources :posts
  end # constraints

end
