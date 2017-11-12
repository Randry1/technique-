Rails.application.routes.draw do
  # root to: "/regions/42/mechanisms"
  resources :regions do
    resources :mechanisms
  end

  get 'bootregions', to: 'regions#bootRegions'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
