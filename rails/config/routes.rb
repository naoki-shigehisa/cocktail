Rails.application.routes.draw do
  get 'material/list', to: 'material#list'
  get 'material/detail/:id', to: 'material#detail'
  get 'recipe/list', to: 'recipe#list'
  get 'recipe/detail/:id', to: 'recipe#detail'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
