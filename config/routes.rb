Funkardet::Application.routes.draw do
  #scope "(:locale)", locale: /en|sv/ do
    get "/login" => "user_sessions#new", as: :login
    get "/logout" => "user_sessions#destroy", as: :logout
    get "/login/select_user" => "user_sessions#select_user", as: :select_user
    post "/login/select_user" => "user_sessions#select_user_post", as: :select_user_post

    resources :users
    resources :user_sessions, only: [:new, :create]

    resources :groups do
      resources :group_dates do
        post :attend_date
      end
      resources :group_members
    end

    root 'user_sessions#new'
  #end
end
