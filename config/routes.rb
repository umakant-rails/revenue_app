Rails.application.routes.draw do
  root 'welcome#index'
  
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  # resources :requests do 
  #   resources :participants do
  #     get '/balees' => "participants#get_balees", as: :get_balees, on: :collection
  #   end

  #   resources :khasras    
  #   get '/pending' => "requests#pending", as: :pending, on: :collection
  #   get '/get_records' => "requests#get_records", as: :get_records, on: :collection
  #   get '/pdf/export' => "requests#export", as: :export_pdf, on: :member
  #   get '/payment' => "requests#payment_page", as: :payment_page, on: :member
  #   post '/make_payment' => "requests#make_payment", as: :make_payment, on: :member
  # end

  # resources :orders do 
  #   post '/initiate_order' => "orders#initiate_a_order", as: :initiate_order, on: :collection
  #   post '/webhook' => "orders#webhook", as: :webhook, on: :collection
  #   get '/transactions' => "orders#transactions", as: :transactions, on: :collection
  # end
end
