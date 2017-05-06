Rails.application.routes.draw do

  resources :attachments,       only: [:index, :show]
  resources :backgrounds,       except: [:new, :create, :destroy]
  resources :consultations,     except: [:new, :create, :destroy]
  resources :diagnostics,       only: [:index, :show]
  resources :insurances,        only: [:index, :show]
  resources :medical_records,   except: [:new, :create, :destroy]
  resources :medicines,         only: [:index, :show]
  resources :occupations,       only: [:index, :show]
  resources :physical_exams,    except: [:new, :create, :destroy]
  resources :prescriptions,     only: [:index, :show]
  resources :procedures,        only: [:index, :show]
  resources :reasons,           only: [:index, :show]
  resources :users

  get 'search_records', to: 'medical_records#search'

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
