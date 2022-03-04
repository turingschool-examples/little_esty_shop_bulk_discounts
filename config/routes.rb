Rails.application.routes.draw do
  get 'bulk_discounts/index'
  get 'bulk_discounts/show'
  get 'bulk_discounts/new'
  get 'bulk_discounts/create'
  get 'bulk_discounts/update'
  get 'bulk_discounts/delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchant, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end
end
