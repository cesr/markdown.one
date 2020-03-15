Rails.application.routes.draw do
  
  scope module: 'api', path: 'api' do
    resources :posts
  end

  get "/p/:id", controller: 'posts', action: 'show', as: 'show_post'

  get "/edit", controller: 'edit', action: 'index', as: 'edit'
  get "/edit/*path", to: redirect("/edit?redirect=%{path}"), via: :all
  
  root "edit#index"

end
