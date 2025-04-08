Rails.application.routes.draw do
  root "empresas#index"
  resources :empresas do
    member do
      post :export
    end
  end
end