Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'jobs#index'
  resources :jobs, only:[:show, :new, :create, :edit, :update]
  resources :companies, only:[:new, :create, :show, :update]
end
