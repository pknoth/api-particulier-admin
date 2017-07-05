Rails.application.routes.draw do
  scope path: '/admin' do
    resources :tokens
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tokens#index'
end
