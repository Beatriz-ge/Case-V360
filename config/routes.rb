Rails.application.routes.draw do
  resources :todo_lists, only: [:index, :show, :new, :create, :destroy] do
    resources :tasks, only: [:create, :update, :destroy]
end

  get "up" => "rails/health#show", as: :rails_health_check
  root "todo_lists#index"
end
