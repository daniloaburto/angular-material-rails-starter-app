Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    # Root
    get 'home/index', to: 'home#index'
    get '/home', to: 'home#index'
    get '/', to: 'home#index'
    # root 'home#index'

    # Resources

  end
end
