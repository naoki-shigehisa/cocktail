Rails.application.routes.draw do
  # Welcome
  root to: 'application#welcome'
  get 'do_not_come_to_shigehisa', to: 'application#do_not_come_to_shigehisa'

  namespace "materials" do
    get '/', to: 'index#all'
    get '/menu', to: 'index#menu'
    get '/detail/:id', to: 'index#detail'
  end

  namespace "recipes" do
    get '/', to: 'index#all'
    get '/menu', to: 'index#menu'
    get '/detail/:id', to: 'index#detail'
    get '/menu_only_name', to: 'index#menu_only_name'
    get '/drank', to: 'index#drank'

    # random_choice
    get 'random_choice/terms', to: 'random_choice#terms'
    get 'random_choice/order', to: 'random_choice#order'
    get 'random_choice/order_secret', to: 'random_choice#order_secret'
  end

  namespace :orders do
    get '/', to: 'index#index'
    get '/myorder', to: 'index#myorder'
    get '/detail/:id', to: 'index#detail'
    get '/create/:recipe_id', to: 'index#create'
    get '/done/:id', to:'index#done'
    get '/done_by_user/:id', to:'index#done_by_user'
  end

  namespace :users do
    get 'ranking', to: 'index#ranking'
    get 'login_page', to: 'index#login_page'
    get 'login', to: 'index#login'
    get 'logout', to: 'index#logout'
  end

  namespace :reviews do
    post 'create', to: 'index#create'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
