Rails.application.routes.draw do
  # Welcome
  root to: 'application#welcome'
  get 'do_not_come_to_shigehisa', to: 'application#do_not_come_to_shigehisa'

  # materials
  get 'material/list', to: 'material#list'
  get 'material/detail/:id', to: 'material#detail'
  get 'material/all', to: 'material#all'

  # recipes
  get 'recipe/list', to: 'recipe#list'
  get 'recipe/detail/:id', to: 'recipe#detail'
  get 'recipe/all', to: 'recipe#all'
  get 'recipe/list_only_name', to: 'recipe#list_only_name'

  # random_choice
  get 'random_choice/terms', to: 'random_choice#terms'
  get 'random_choice/order', to: 'random_choice#order'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
