Rails.application.routes.draw do
  
  scope module: 'api', path: 'api' do
    resources :posts
  end

  get "/edit", controller: 'edit', action: 'index', as: 'edit'
  get "/edit/*path", to: redirect("/edit?redirect=%{path}"), via: :all
  
  root "edit#index"

end
