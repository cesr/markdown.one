Rails.application.routes.draw do
  scope module: 'api', path: 'api' do
    resources :posts
  end
end
