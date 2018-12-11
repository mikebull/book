require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :chapters
    resources :comments
    resources :paragraphs

    root to: "chapters#index"
  end

  root 'chapters#index'
  resources :chapters, param: :slug do
    resources :comments, path: "comments/:paragraph_id", defaults: { paragraph_id: nil }
  end
  
  mount Sidekiq::Web => '/sidekiq'
end
