Rails.application.routes.draw do
  resources :articles, only: %i[show index new create edit update]
end
