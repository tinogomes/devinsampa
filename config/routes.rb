ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :speakers,
      :collection => { :report => :get }
    admin.resources :agendas
    admin.resources :presentations
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

  map.resources :attendees, :as => "inscricao", :only => [:create]
  map.register '/inscricao', :controller => "attendees", :action => "new"
  map.payment  '/inscricao/pagamento/:token', :controller => "attendees", :action => "payment"
  map.pagseguro_confirmation "/inscricao/pagseguro/confirmacao", :controller => "attendees", :action => "pagseguro"

  map.with_options :controller => 'user_sessions' do |user_sessions|
    user_sessions.login         "/login",        :action => "new"
    user_sessions.logout        "/logout",       :action => "destroy"
  end

  map.with_options :controller => 'pages' do |pages|
    pages.home                   "/",                :action => "index"
    pages.contact                "/contato",         :action => "contact"
    pages.photos_and_videos_2009 "/2009",            :action => "photos_and_videos_2009"
    pages.presentations          "/palestras",       :action => "presentations"
    pages.agenda                 "/programacao",     :action => "agenda"
    # pages.feedback               "/feedback",        :action => "feedback"
  end

  map.admin "/admin", :controller => "Admin::Admin", :action => "index"

  map.not_found "*minvalid_route", :controller => 'pages', :action => 'not_found'
end