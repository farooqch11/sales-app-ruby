# == Route Map
#
#                                   Prefix Verb   URI Pattern                                   Controller#Action
#                          item_categories GET    /item_categories(.:format)                    item_categories#index
#                                          POST   /item_categories(.:format)                    item_categories#create
#                        new_item_category GET    /item_categories/new(.:format)                item_categories#new
#                       edit_item_category GET    /item_categories/:id/edit(.:format)           item_categories#edit
#                            item_category GET    /item_categories/:id(.:format)                item_categories#show
#                                          PATCH  /item_categories/:id(.:format)                item_categories#update
#                                          PUT    /item_categories/:id(.:format)                item_categories#update
#                                          DELETE /item_categories/:id(.:format)                item_categories#destroy
#                           companies GET    /companies(.:format)                     companies#index
#                                          POST   /companies(.:format)                     companies#create
#                        new_configuration GET    /companies/new(.:format)                 companies#new
#                       edit_configuration GET    /companies/:id/edit(.:format)            companies#edit
#                            configuration GET    /companies/:id(.:format)                 companies#show
#                                          PATCH  /companies/:id(.:format)                 companies#update
#                                          PUT    /companies/:id(.:format)                 companies#update
#                                          DELETE /companies/:id(.:format)                 companies#destroy
#                     total_report_reports GET    /reports/total_report(.:format)               reports#total_report
#                date_range_report_reports GET    /reports/date_range_report(.:format)          reports#date_range_report
#                  customer_report_reports GET    /reports/customer_report(.:format)            reports#customer_report
#                      item_report_reports GET    /reports/item_report(.:format)                reports#item_report
#                                  reports GET    /reports(.:format)                            reports#index
#                                          POST   /reports(.:format)                            reports#create
#                               new_report GET    /reports/new(.:format)                        reports#new
#                              edit_report GET    /reports/:id/edit(.:format)                   reports#edit
#                                   report GET    /reports/:id(.:format)                        reports#show
#                                          PATCH  /reports/:id(.:format)                        reports#update
#                                          PUT    /reports/:id(.:format)                        reports#update
#                                          DELETE /reports/:id(.:format)                        reports#destroy
#                               line_items GET    /line_items(.:format)                         line_items#index
#                                          POST   /line_items(.:format)                         line_items#create
#                            new_line_item GET    /line_items/new(.:format)                     line_items#new
#                           edit_line_item GET    /line_items/:id/edit(.:format)                line_items#edit
#                                line_item GET    /line_items/:id(.:format)                     line_items#show
#                                          PATCH  /line_items/:id(.:format)                     line_items#update
#                                          PUT    /line_items/:id(.:format)                     line_items#update
#                                          DELETE /line_items/:id(.:format)                     line_items#destroy
#                    make_payment_payments GET    /payments/make_payment(.:format)              payments#make_payment
#                                 payments GET    /payments(.:format)                           payments#index
#                                          POST   /payments(.:format)                           payments#create
#                              new_payment GET    /payments/new(.:format)                       payments#new
#                             edit_payment GET    /payments/:id/edit(.:format)                  payments#edit
#                                  payment GET    /payments/:id(.:format)                       payments#show
#                                          PATCH  /payments/:id(.:format)                       payments#update
#                                          PUT    /payments/:id(.:format)                       payments#update
#                                          DELETE /payments/:id(.:format)                       payments#destroy
#                                          GET    /companies/update(.:format)              companies#update
#                                          GET    /companies(.:format)                     companies#index
#                                          POST   /companies(.:format)                     companies#create
#                                          GET    /companies/new(.:format)                 companies#new
#                                          GET    /companies/:id/edit(.:format)            companies#edit
#                                          GET    /companies/:id(.:format)                 companies#show
#                                          PATCH  /companies/:id(.:format)                 companies#update
#                                          PUT    /companies/:id(.:format)                 companies#update
#                                          DELETE /companies/:id(.:format)                 companies#destroy
#                                customers GET    /customers(.:format)                          customers#index
#                                          POST   /customers(.:format)                          customers#create
#                             new_customer GET    /customers/new(.:format)                      customers#new
#                            edit_customer GET    /customers/:id/edit(.:format)                 customers#edit
#                                 customer GET    /customers/:id(.:format)                      customers#show
#                                          PATCH  /customers/:id(.:format)                      customers#update
#                                          PUT    /customers/:id(.:format)                      customers#update
#                                          DELETE /customers/:id(.:format)                      customers#destroy
#                              item_search GET    /items/:item_id/search(.:format)              items#search
#                             search_items GET    /items/search(.:format)                       items#search
#                                    items GET    /items(.:format)                              items#index
#                                          POST   /items(.:format)                              items#create
#                                 new_item GET    /items/new(.:format)                          items#new
#                                edit_item GET    /items/:id/edit(.:format)                     items#edit
#                                     item GET    /items/:id(.:format)                          items#show
#                                          PATCH  /items/:id(.:format)                          items#update
#                                          PUT    /items/:id(.:format)                          items#update
#                                          DELETE /items/:id(.:format)                          items#destroy
#           update_line_item_options_sales GET    /sales/update_line_item_options(.:format)     sales#update_line_item_options
#            update_customer_options_sales GET    /sales/update_customer_options(.:format)      sales#update_customer_options
#                   create_line_item_sales GET    /sales/create_line_item(.:format)             sales#create_line_item
#                      update_totals_sales GET    /sales/update_totals(.:format)                sales#update_totals
#                           add_item_sales GET    /sales/add_item(.:format)                     sales#add_item
#                        remove_item_sales GET    /sales/remove_item(.:format)                  sales#remove_item
#        create_customer_association_sales GET    /sales/create_customer_association(.:format)  sales#create_customer_association
#                 create_custom_item_sales GET    /sales/create_custom_item(.:format)           sales#create_custom_item
#             create_custom_customer_sales GET    /sales/create_custom_customer(.:format)       sales#create_custom_customer
#                        add_comment_sales GET    /sales/add_comment(.:format)                  sales#add_comment
#                     override_price_sales POST   /sales/override_price(.:format)               sales#override_price
#                      sale_discount_sales POST   /sales/sale_discount(.:format)                sales#sale_discount
#                                    sales GET    /sales(.:format)                              sales#index
#                                          POST   /sales(.:format)                              sales#create
#                                 new_sale GET    /sales/new(.:format)                          sales#new
#                                edit_sale GET    /sales/:id/edit(.:format)                     sales#edit
#                                     sale GET    /sales/:id(.:format)                          sales#show
#                                          PATCH  /sales/:id(.:format)                          sales#update
#                                          PUT    /sales/:id(.:format)                          sales#update
#                                          DELETE /sales/:id(.:format)                          sales#destroy
# create_sale_with_product_dashboard_index GET    /dashboard/create_sale_with_product(.:format) dashboard#create_sale_with_product
#                          dashboard_index GET    /dashboard(.:format)                          dashboard#index
#                                          POST   /dashboard(.:format)                          dashboard#create
#                            new_dashboard GET    /dashboard/new(.:format)                      dashboard#new
#                           edit_dashboard GET    /dashboard/:id/edit(.:format)                 dashboard#edit
#                                dashboard GET    /dashboard/:id(.:format)                      dashboard#show
#                                          PATCH  /dashboard/:id(.:format)                      dashboard#update
#                                          PUT    /dashboard/:id(.:format)                      dashboard#update
#                                          DELETE /dashboard/:id(.:format)                      dashboard#destroy
#                         new_user_session GET    /users/sign_in(.:format)                      devise/sessions#new
#                             user_session POST   /users/sign_in(.:format)                      devise/sessions#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                     devise/sessions#destroy
#                            user_password POST   /users/password(.:format)                     devise/passwords#create
#                        new_user_password GET    /users/password/new(.:format)                 devise/passwords#new
#                       edit_user_password GET    /users/password/edit(.:format)                devise/passwords#edit
#                                          PATCH  /users/password(.:format)                     devise/passwords#update
#                                          PUT    /users/password(.:format)                     devise/passwords#update
#                           new_user_users POST   /users/new_user(.:format)                     users#new_user
#                                    users GET    /users(.:format)                              users#index
#                                          POST   /users(.:format)                              users#create
#                                 new_user GET    /users/new(.:format)                          users#new
#                                edit_user GET    /users/:id/edit(.:format)                     users#edit
#                                     user GET    /users/:id(.:format)                          users#show
#                                          PATCH  /users/:id(.:format)                          users#update
#                                          PUT    /users/:id(.:format)                          users#update
#                                          DELETE /users/:id(.:format)                          users#destroy
#                                     root GET    /                                             companies#index
#

PushvendorPos::Application.routes.draw do


  get "password/change", to: "passwords#edit" , as: :change_password
  # get 'configuration' , to: "configuration#edit" , as: :configuration

  # Active Admin Routes
  devise_for :sites, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :expenses
  resources :item_categories
  resources :companies
  resources :configuration , only: [:edit , :update]
  resources :passwords , only: [:edit , :update]
  resources :customers
  resources :static , only: [:index]
  resources :line_items
  resources :locations
  resources :finance do
    collection do
      post :financial_position
    end
  end

  resources :dashboard do
    collection do
      post :change_location
    end
  end


  resources :reports do
    collection do
      post :get_location_employees
      get 'total_report'
      get 'date_range_report'
      get 'customer_report'
      get 'item_report'
      get :sales
      get :inventory
      get :dead_inventory
    end
  end



  resources :payments do
    collection do
      post :make_payment
    end
  end


  resources 'companies' do
    collection do
      get 'update'
    end
  end



  resources :items do
    get 'search'
    collection do
      get 'search'
    end
  end

  resources :sales do
    member do
      get 'issue_refund'
      get 'invoice'
    end
    collection do
      post 'update_line_item_options'
      get 'update_customer_options'
      get 'create_line_item'
      get 'update_totals'
      get 'add_item'
      get 'remove_item'
      get 'remove_lineitem'
      post 'empty_cart'
      get 'create_customer_association'
      get 'create_custom_item'
      get 'create_custom_customer'
      get 'add_comment'
      post 'override_price'
      post 'sale_discount'
    end
  end

  resources :dashboard do
    collection do
      get 'create_sale_with_product'
    end
  end

  # devise_for :users
  devise_for :users
  resources :users do
    collection do
      post 'new_user'
    end
  end



  match '/', to: 'companies#new', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'dashboard#index', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]


  # match '' , to: 'companies#show' , constraints: lambda {|r| r.subdomain.present? && r.subdomain != "www"}
  #   root 'companies#new'
    root 'static#index'
end
