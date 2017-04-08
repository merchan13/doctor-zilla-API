Rails.application.routes.draw do

  resources :users
  resources :medical_records, except: :create
  #resources :user_medical_records, only: [:create, :update]

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
