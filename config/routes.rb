Rails.application.routes.draw do
  namespace :api do
    resources :templates, only: :index, defaults: { format: :json }
  end
end
