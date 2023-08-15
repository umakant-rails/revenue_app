Rails.application.routes.draw do

  namespace :admin do
    resources :form_templates
    resources :requests
  end
  
  root 'welcome#index'

  resources :welcome, only: [:index] do
    get '/autocomplete_term' => "welcome#autocomplete_term", as: :autocomplete_term, on: :collection
    get '/form/search' => "welcome#form_search", as: :form_search, on: :collection
  end
  
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  resources :requests do 
    resources :participants do
      get '/balees' => "participants#get_balees", as: :get_balees, on: :collection
    end

    resources :khasras

    resources :khasra_battanks do
      post '/add_participants' => "khasra_battanks#add_participants", as: :add_participants, on: :collection
      post '/remove_participant' => "khasra_battanks#remove_participant", as: :remove_participant, on: :member
    end

    get '/pending' => "requests#pending", as: :pending, on: :collection
    # get '/pending' => "requests#pending_request", as: :pending_request, on: :member
    get '/get_records' => "requests#get_records", as: :get_records, on: :collection
    get '/pdf/export' => "requests#export", as: :export_pdf, on: :member
    get '/payment' => "requests#payment_page", as: :payment_page, on: :member
    post '/make_payment' => "requests#make_payment", as: :make_payment, on: :member

    get '/order_page' => "requests#order_page", as: :order_page, on: :member
    get '/create_order' => "requests#order_page", as: :create_order, on: :member
  end

  resources :orders do 
    post '/initiate_order' => "orders#initiate_a_order", as: :initiate_order, on: :collection
    post '/webhook' => "orders#webhook", as: :webhook, on: :collection
    get '/transactions' => "orders#transactions", as: :transactions, on: :collection
  end

  resources :order_templates

  resources :blank_forms, only: :index do 
    # namespace: 'revenue' do
    #   get '/' => 'blank_forms#index', as: :revenue, on: :collection
    # end
    get '/departments/:department' => 'blank_forms#department', as: :department,  on: :collection
    get '/departments/:department/section/:section' => 'blank_forms#show', as: :section, on: :collection
    get '/departments/:department/:id' => 'blank_forms#show', as: :show, on: :collection

    get '/get_records' => "blank_forms#get_records", as: :get_records, on: :collection 
    get '/departments' => "blank_forms#get_departments", as: :get_department, on: :collection

  end

  resources :pdfs, only: [:index] do
    get '/imagetopdf' => "pdfs#image_to_pdf", as: :imagetopdf, on: :collection
    post '/convert/imagetopdf' => "pdfs#convert_image_to_pdf", as: :convert_imagetopdf, on: :collection
  end

end
