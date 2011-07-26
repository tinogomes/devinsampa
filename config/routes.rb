# encoding: utf-8
Devinsampa::Application.routes.draw do
  root :to => "pages#index"

  namespace :admin do
    resources :agendas, :presentations

    resources :speakers do
      get "report", :on => :collection
    end

    get "settings/edit" => "system_configurations#edit", :as => "settings"
    put "settings/update" => "system_configurations#update", :as => "update_settings"

    resources :attendees do
      member do
        get "resend"
        put "completed"
        put "pending"
        put "approved"
        put "verifying"
        put "canceled"
        put "refunded"
        get "warning"
      end

      get "report", :on => :collection
    end
  end
  get "/admin" => "Admin::Admin#index"

  get "/login" => "user_sessions#new", :as => "login"
  delete "/logout" => "user_sessions#destroy", :as => "logout"
  resources :user_sessions, :only => [:new, :create, :destroy]

  resources :attendees, :only => [:create], :path => "inscricao"
  get "/inscricao" => "attendees#new", :as => "register"
  get "/inscricao/pagamento/:token" => "attendees#payment", :as => "payment"
  match "/inscricao/pagseguro/confirmacao" => "attendees#pagseguro", :via => [:get, :post], :as => "pagseguro_confirmation"

  get "/contato" => "pages#contact", :as => "contact"
  get "/2009" => "pages#photos_and_videos_2009", :as => "photos_and_videos_2009"
  get "/palestras" => "pages#presentations", :as => "presentations"
  get "/programacao" => "pages#agenda", :as => "agenda"

  match "/palestrantes" => redirect("/palestras")
  match "/divulgar" => redirect("/")
  match "/feedback" =>  redirect("/contato")

  match "*minvalid_route.php" => "pages#php"
  match "*minvalid_route" => "pages#not_found", :as => "not_found"
end
