Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do


  
    # Root
    get 'home/index', to: 'home#index'
    get '/home', to: 'home#index'
    get '/', to: 'home#index'
    # root 'home#index'

    # Resources


    # Devise
    # devise_for :users, path: '',
    #   path_names: {
    #     sign_in: 'login',
    #     sign_out: 'logout',
    #     password: 'reset_password'
    #   }
    #
    # devise_scope :users do
    #
    #   # Passwords match
    #   match '/reset_password/:reset_password_token', to: 'devise/passwords#edit', as: :reset_user_password, via: :get
    #
    #   # Unlock match
    #   match '/unlock/:unlock_token', to: 'devise/unlocks#show', as: 'unlock_user', via: :get
    #
    #   # Root to authenticated users
    #   authenticated :users do
    #     root to: 'home#index', as: 'authenticated_root', path: 'home'
    #     #get '/', to: 'home#index', as: 'authenticated_home'
    #     #root to: redirect('/home'), as: 'authenticated_root'
    #   end
    #
    #   # Root to unauthenticated users
    #   unauthenticated  do
    #     root to: 'devise/sessions#new', as: 'unauthenticated_root', path: 'login'
    #     #get '/', to: 'devise/sessions#new', as: 'unauthenticated_home'
    #     #root to: redirect('/login'), as: 'unauthenticated_root'
    #   end
    # end

    # Error views
    #get "/404", to: "errors#not_found"
    #get "/422", to: "errors#unacceptable"
    #get "/500", to: "errors#internal_server_error"
  end

end
