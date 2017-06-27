Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :customers do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      namespace :merchants do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      namespace :transactions do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      resources :transactions, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
      end
      resources :invoices, only: [:index, :show]
    end
  end
end
