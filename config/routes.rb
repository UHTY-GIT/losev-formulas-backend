Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount SwaggerUiEngine::Engine, at: "/api_docs"

  namespace :api do
    namespace :v1 do

      resources :users, only: [:show] do
        post :sign_up, on: :collection
        post :sign_in, on: :collection
        put :profile_update, on: :collection
        post :logout, on: :collection
        get :profile, on: :collection
        post :change_password, on: :collection
      end

      resources :categories, only: [:index]

      resources :podcasts, only: [:index] do

      end

      resource :ratings, only: [] do
        post :set_rating, :collection
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
