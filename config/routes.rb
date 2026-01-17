Rails.application.routes.draw do
  # Rotas RESTful para listas
  resources :todo_lists, only: [:index, :show, :new, :create] do
    # Tasks aninhadas dentro das listas
    resources :tasks, only: [:create, :update, :destroy]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a página inicial do app (root)
  root "todo_lists#index"
end
