Rails.application.routes.draw do

  scope module: 'api' do
    namespace :v1 do
      resources :attachments,       only:     [:index, :show]
      resources :backgrounds,       only:     [:index, :show, :update]
      resources :consultations,     only:     [:index, :show, :update, :create]
      resources :diagnostics,       only:     [:index, :show]
      resources :insurances,        only:     [:index, :show]
      resources :medical_records,   only:     [:index, :show, :update]
      resources :occupations,       only:     [:index, :show]
      resources :operative_notes,   only:     [:index, :show]
      resources :physical_exams,    only:     [:index, :show, :update]
      resources :plans,             only:     [:index, :show]
      resources :procedures,        only:     [:index, :show]
      resources :reasons,           only:     [:index, :show]
      resources :reports,           only:     [:index, :show]
      resources :users
      resources :syncs,             only:     [:index, :create]

      get 'plans/:plan_id/procedures',                        to: 'procedures#index_plan',          as: 'plan_procedures'
      get 'procedures/:procedure_id/plans',                   to: 'plans#index_procedure',          as: 'procedure_plans'
      get 'consultations/:consultation_id/diagnostics',       to: 'diagnostics#index_consultation', as: 'consultation_diagnostics'

      put 'medical_records/:medical_record_id/backgrounds',   to: 'backgrounds#update_record_backgrounds', as: 'record_background_update'

      get 'search_records',     to: 'medical_records#search'

      get 'last_sync',            to: 'syncs#last_sync'
      get 'latest_data',          to: 'syncs#latest_data'

      post 'set_syncs_actions',   to: 'syncs#set_actions'

      post    'sign-in',     to: 'sessions#create'
      delete  'sign-out',  to: 'sessions#destroy'

      get 'activities_report', to: 'activities#index'
    end
  end

end
