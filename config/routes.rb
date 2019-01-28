Rails.application.routes.draw do

  resources :movies

  root to: 'pages#welcome'

end
