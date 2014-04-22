HtBattle::Application.routes.draw do
  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'battles#index'
  resources :hashtags
  #resources :hashtags
  resources :battles do
    post 'start'
    post 'end'
  end

  get 'present.js' => "battles#present"
end
