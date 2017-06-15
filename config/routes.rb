Rails.application.routes.draw do

  resources :attachments,       only:     [:index, :show]
  resources :backgrounds,       only:     [:index, :show, :update]
  resources :consultations,     only:     [:index, :show, :update]
  resources :diagnostics,       only:     [:index, :show]
  resources :insurances,        only:     [:index, :show]
  resources :medical_records,   only:     [:index, :show, :update]
  resources :medicines,         only:     [:index, :show]
  resources :occupations,       only:     [:index, :show]
  resources :operative_notes,   only:     [:index, :show, :update]
  resources :physical_exams,    only:     [:index, :show, :update]
  resources :plans,             only:     [:show, :update]
  resources :prescriptions,     only:     [:index, :show]
  resources :procedures,        only:     [:index, :show]
  resources :reasons,           only:     [:index, :show]
  resources :users
  resources :synchs,            only:     [:index, :create]

  get 'plans/:plan_id/procedures', to: 'procedures#index_plan', as: 'plan_procedures'
  get 'procedures/:procedure_id/plans', to: 'plans#index_procedure', as: 'procedures_plan'

  get 'prescriptions/:prescription_id/medicines', to: 'medicines#index_prescription', as: 'prescription_medicines'
  get 'medicines/:medicine_id/prescriptions', to: 'prescriptions#index_medicine', as: 'medicines_prescription'

  get 'search_records', to: 'medical_records#search'
  get 'latest_updates', to: 'synchs#latest_updates'
  get 'last_synch',     to: 'synchs#last_synch' 

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
