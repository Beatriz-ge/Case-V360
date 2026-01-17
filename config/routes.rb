Rails.application.routes.draw do
  resources :todo_lists do
    resources :tasks, only: [:create, :edit, :update, :destroy] do
      member do
        patch :toggle 
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "todo_lists#index"
end
