Rails.application.routes.draw do
  # Welcome
  root to: 'application#welcome'
  get 'do_not_come_to_shigehisa', to: 'application#do_not_come_to_shigehisa'

  # popular
  get 'popular', to: 'application#popular'

  # materials
  get 'material/list', to: 'material#list'
  get 'material/detail/:id', to: 'material#detail'
  get 'material/all', to: 'material#all'

  # recipes
  get 'recipe/list', to: 'recipe#list'
  get 'recipe/detail/:id', to: 'recipe#detail'
  get 'recipe/all', to: 'recipe#all'
  get 'recipe/list_only_name', to: 'recipe#list_only_name'

  # orders
  get 'orders', to: 'orders#index'
  get 'order/:id', to: 'orders#order'
  get 'order/detail/:id', to: 'orders#detail'
  get 'order/done/:id', to: 'orders#done'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
