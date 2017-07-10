Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'jobs#index'
  get '/my_jobs', to: 'jobs#my_jobs'
  get '/my_companies', to: 'companies#my_companies'
  resources :jobs, only:[:show, :new, :create, :edit, :update]
  resources :companies, only:[:new, :create, :show, :edit, :update]
  resources :categories, only:[:new, :create, :show]
end
