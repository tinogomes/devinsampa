ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :speakers,
      :collection => { :report => :get }
    admin.resources :agendas
    admin.resources :attendees,
      :member => { :resend => :get,
                   :completed => :put,
                   :pending => :put,
                   :approved => :put,
                   :verifying => :put,
                   :canceled => :put,
                   :refunded => :put,
                   :warning => :get
                    },
      :collection => { :report => :get }
  end

  map.resources :user_sessions, :as => "admin/acesso"

  # map.resources :attendees, :as => "inscricao", :only => [:create]
  # map.register '/inscricao', :controller => "attendees", :action => "new"
  # map.payment  '/inscricao/pagamento/:token', :controller => "attendees", :action => "payment"
  # map.pagseguro_confirmation "/inscricao/pagseguro/confirmacao", :controller => "attendees", :action => "pagseguro"

  map.with_options :controller => 'user_sessions' do |user_sessions|
    user_sessions.login         "/login",        :action => "new"
    user_sessions.logout        "/logout",       :action => "destroy"
  end

  map.with_options :controller => 'pages' do |pages|
    pages.home       "/",                :action => "index"
    # pages.send_presentation "/quero-palestrar", :action => 'send_presentation'
    pages.contact    "/contato",         :action => "contact"
    # pages.banners    "/divulgar",        :action => "banners"
    # pages.speakers   "/palestrantes",    :action => "speakers"
    # pages.agenda     "/programacao",     :action => "agenda"
    # pages.feedback   "/feedback",        :action => "feedback"
  end

  map.admin "/admin", :controller => "Admin::Admin", :action => "index"
end

# The priority is based upon order of creation: first created -> highest priority.

# Sample of regular route:
#   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
# Keep in mind you can assign values other than :controller and :action

# Sample of named route:
#   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
# This route can be invoked with purchase_url(:id => product.id)

# Sample resource route (maps HTTP verbs to controller actions automatically):
#   map.resources :products

# Sample resource route with options:
#   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

# Sample resource route with sub-resources:
#   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

# Sample resource route with more complex sub-resources
#   map.resources :products do |products|
#     products.resources :comments
#     products.resources :sales, :collection => { :recent => :get }
#   end

# Sample resource route within a namespace:
#   map.namespace :admin do |admin|
#     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
#     admin.resources :products
#   end

# You can have the root of your site routed with map.root -- just remember to delete public/index.html.
#map.root :controller => "pages", :action => "index"

# See how all your routes lay out with "rake routes"

# Install the default routes as the lowest priority.
# Note: These default routes make all actions in every controller accessible via GET requests. You should
# consider removing or commenting them out if you're using named routes and resources.
# map.connect ':controller/:action/:id'
# map.connect ':controller/:action/:id.:format'
