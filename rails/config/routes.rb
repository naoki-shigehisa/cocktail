Rails.application.routes.draw do
  # Welcome
  root to: 'application#welcome'
  get 'do_not_come_to_shigehisa', to: 'application#do_not_come_to_shigehisa'

  namespace "materials" do
    get '/', to: 'index#all'
    get '/list', to: 'index#list'
    get '/detail/:id', to: 'index#detail'
  end

  namespace "recipes" do
    get '/', to: 'index#all'
    get '/list', to: 'index#list'
    get '/detail/:id', to: 'index#detail'
    get '/list_only_name', to: 'index#list_only_name'

    # random_choice
    get 'random_choice/terms', to: 'random_choice#terms'
    get 'random_choice/order', to: 'random_choice#order'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
