Rails.application.routes.draw do

  #devise_for :users, skip: [:registrations]
  resources :users

  post 'sign-in', to: 'sessions#create'
  delete 'sign-out', to: 'sessions#destroy'

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :users
      end
    end
  end

end
