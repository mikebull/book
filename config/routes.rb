Rails.application.routes.draw do
  root 'chapters#index'
  resources :chapters, param: :slug do
    resources :comments, path: "comments/:paragraph_id", defaults: { paragraph_id: nil }
  end
end
