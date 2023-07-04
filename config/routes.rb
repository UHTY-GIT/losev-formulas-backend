Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount SwaggerUiEngine::Engine, at: "/api_docs"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
