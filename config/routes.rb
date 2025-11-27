Rails.application.routes.draw do
  # API routes with versioning
  namespace :api do
    namespace :v1 do
      # Devise routes for authentication
      devise_for :users,
                 path: '',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
                 },
                 controllers: {
                   sessions: 'api/v1/sessions',
                   registrations: 'api/v1/registrations'
                 }

      # Your API resources go here
      # Example:
      # resources :posts
      # resources :comments
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
