Rails.application.routes.draw do
  get 'material/list', to: 'material#list'
  get 'material/detail/:id', to: 'material#detail'
  get 'material/all', to: 'material#all'

  get 'recipe/list', to: 'recipe#list'
  get 'recipe/detail/:id', to: 'recipe#detail'
  get 'recipe/all', to: 'recipe#all'
  get 'recipe/list_only_name', to: 'recipe#list_only_name'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
