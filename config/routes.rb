Myapp::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:registrations => "registrations"} 
  resources :organizations do
    resources :divisions do
      resources :departments        
    end
  end
  
  resources :plans
  resources :assets  
  resources :goals do
    collection do
      get "get_selected_division", to: "goals#get_selected_division", as: :get_selected_division
      get "get_selected_area_goals", to:"goals#get_selected_area_goals", as: :get_selected_area_goals
      get "new_goal_attachment/:goal_id", to: "goals#new_goal_attachment", as: :new_goal_attachment
    end
  end
  resources :areas do 
    collection do
      get "get_selected_division", to: "areas#get_selected_division", as: :get_selected_division
    end
  end
  resources :teams do
    collection do
      post "assign_member", to: "teams#assign_member", as: :assign_member
      delete "remove_assigned_member/:id", to: "teams#remove_assigned_member", as: :remove_assigned_member
    end 
  end
   resources :members, controller: "users" do
     collection do
       get "get_selected_division", to: "users#get_selected_division", as: :get_selected_division
     end
   end

   scope :users do
     get "forgot_password", to: "users#forgot_password", as: :forgot_password 
     post 'generate_new_password_email', to: "users#generate_new_password_email", as: :generate_new_password_email
   end
   
   root to: 'dashboards#dashboard_1'

   # All routes
   get "dashboards/dashboard_1"
   get "dashboards/dashboard_2"
   get "dashboards/dashboard_3"
   get "dashboards/dashboard_4"
   get "dashboards/dashboard_4_1"
   get "dashboards/dashboard_5"

   get "layoutsoptions/index"
   get "layoutsoptions/off_canvas"

   get "graphs/flot"
   get "graphs/morris"
   get "graphs/rickshaw"
   get "graphs/chartjs"
   get "graphs/chartist"
   get "graphs/peity"
   get "graphs/sparkline"
   get "graphs/c3charts"

   get "mailbox/inbox"
   get "mailbox/email_view"
   get "mailbox/compose_email"
   get "mailbox/email_templates"
   get "mailbox/basic_action_email"
   get "mailbox/alert_email"
   get "mailbox/billing_email"

   get "metrics/index"

   get "widgets/index"

   get "forms/basic_forms"
   get "forms/advanced"
   get "forms/wizard"
   get "forms/file_upload"
   get "forms/text_editor"
   get "forms/autocomplete"
   get "forms/markdown"

   get "appviews/contacts"
   get "appviews/profile"
   get "appviews/profile_two"
   get "appviews/contacts_two"
   get "appviews/projects"
   get "appviews/project_detail"
   get "appviews/file_menager"
   get "appviews/vote_list"
   get "appviews/calendar"
   get "appviews/faq"
   get "appviews/timeline"
   get "appviews/pin_board"
   get "appviews/teams_board"
   get "appviews/social_feed"
   get "appviews/clients"
   get "appviews/outlook_view"
   get "appviews/blog"
   get "appviews/article"
   get "appviews/issue_tracker"

   get "pages/search_results"
   get "pages/lockscreen"
   get "pages/invoice"
   get "pages/invoice_print"
   get "pages/login"
   get "pages/login_2"
   get "pages/forgot_password"
   get "pages/register"
   get "pages/not_found_error"
   get "pages/internal_server_error"
   get "pages/empty_page"

   get "miscellaneous/notification"
   get "miscellaneous/nestablelist"
   get "miscellaneous/timeline_second_version"
   get "miscellaneous/forum_view"
   get "miscellaneous/forum_post_view"
   get "miscellaneous/google_maps"
   get "miscellaneous/datamaps"
   get "miscellaneous/social_buttons"
   get "miscellaneous/code_editor"
   get "miscellaneous/modal_window"
   get "miscellaneous/validation"
   get "miscellaneous/tree_view"
   get "miscellaneous/chat_view"
   get "miscellaneous/agile_board"
   get "miscellaneous/diff"
   get "miscellaneous/pdf_viewer"
   get "miscellaneous/sweet_alert"
   get "miscellaneous/idle_timer"
   get "miscellaneous/spinners"
   get "miscellaneous/live_favicon"
   get "miscellaneous/masonry"
   get "miscellaneous/tour"
   get "miscellaneous/loading_buttons"
   get "miscellaneous/clipboard"
   get "miscellaneous/truncate"
   get "miscellaneous/i18support"

   get "uielements/typography"
   get "uielements/icons"
   get "uielements/draggable_panels"
   get "uielements/resizeable_panels"
   get "uielements/buttons"
   get "uielements/video"
   get "uielements/tables_panels"
   get "uielements/tabs"
   get "uielements/notifications_tooltips"
   get "uielements/helper_classes"
   get "uielements/badges_labels_progress"

   get "gridoptions/index"

   get "tables/static_tables"
   get "tables/data_tables"
   get "tables/foo_tables"
   get "tables/jqgrid"

   get "commerce/products_grid"
   get "commerce/products_list"
   get "commerce/product_edit"
   get "commerce/product_detail"
   get "commerce/orders"
   get "commerce/cart"
   get "commerce/payments"

   get "gallery/basic_gallery"
   get "gallery/slick_carusela"
   get "gallery/bootstrap_carusela"

   get "cssanimations/index"

   get "landing/index"

end
