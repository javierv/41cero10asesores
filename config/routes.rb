Calesur::Application.routes.draw do

  if ["development", "test"].include? Rails.env
    mount Jasminerice::Engine => "/jasmine" 
  end

  resources :clientes
  resources :translations, only: [:index, :create]
  resources :navegaciones, only: [:new, :create]
  resources :portadas, only: [:new, :update, :create] do
    get :principal, on: :collection
  end

  resources :boletines do
    member do
      get :enviar
      put :email
    end
  end

  resources :fotos, only: [:create] do
    get :thumbnail, on: :member
  end
  devise_for :usuarios

  resources :cajas, except: :show

  resources :vestal_versions_versions, path: 'versions', controller: 'versions',
    only: [:show] do
    member do
      put :recover
      put :restore
      get 'compare(/:ref_id)', action: 'compare', as: :compare
    end
    get :borradas, on: :collection
  end

  match '/autocomplete' => "ajax_form#autocomplete"
  match '/ayuda-textile' => "static#ayuda_textile"

  resources :paginas, only: [:index, :create] do
    post :create_draft, on: :collection
  end
  resources :paginas, path: "", except: [:index, :create] do
    get :search,       on: :collection
    get :historial,    on: :member
    put :update_draft, on: :member
  end

  root to: "portadas#principal"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
