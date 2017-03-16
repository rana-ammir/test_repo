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
  resources :userboards do
    collection do
      get "my_board", to: "userboards#my_board", as: :my_board
      get "get_filtered_tasks", to: "userboards#get_filtered_tasks", as: :get_filtered_tasks
    end
  end
  resources :activities do 
    collection do
      get "get_filtered_tasks", to: "activities#get_filtered_tasks", as: :get_filtered_tasks
    end  
  end
  resources :assets do
    collection do
      get "download_asset", to: "assets#download_asset", as: :download_asset
    end
  end

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
      get "autocomplete_team_name", to: "teams#autocomplete_team_name", as: :autocomplete_team_name
      post "assign_member", to: "teams#assign_member", as: :assign_member
      delete "remove_assigned_member/:id", to: "teams#remove_assigned_member", as: :remove_assigned_member
    end 
  end

  resources :members, controller: "users" do
    collection do
      get "get_selected_division", to: "users#get_selected_division", as: :get_selected_division
    end
  end

  resources :tasks do
    collection do
      post "publish_tactic_task", to: "tasks#publish_tactic_task", as: :publish_tactic_task
      get "new_task_attachment/:id", to: "tasks#new_task_attachment", as: :new_task_attachment
    end
  end

  scope :users do
    get "profile", to: "users#profile", as: :profile
    get "autocomplete_user_name", to: "users#autocomplete_user_name", as: :autocomplete_user_name
    get "forgot_password", to: "users#forgot_password", as: :forgot_password 
    post 'generate_new_password_email', to: "users#generate_new_password_email", as: :generate_new_password_email
  end

  scope :objectives do
    get "new_objective_attachment/:objective_id", to: "objectives#new_objective_attachment", as: :new_objective_attachment  
    get "get_objective_users", to: "objectives#get_objective_users", as: :get_objective_users
    post "create_user_objective", to: "objectives#create_user_objective", as: :create_user_objective
    get "get_objective_teams", to: "objectives#get_objective_teams", as: :get_objective_teams
    post "create_team_objective", to: "objectives#create_team_objective", as: :create_team_objective
    get "destroy_user_objective", to: "objectives#destroy_user_objective", as: :destroy_user_objective
    get "destroy_team_objective", to: "objectives#destroy_team_objective", as: :destroy_team_objective
    put "update_objective_user", to: "objectives#update_objective_user", as: :update_objective_user
  end

  scope :strategies do
    get "new_strategy_attachment/:strategy_id", to: "strategies#new_strategy_attachment", as: :new_strategy_attachment
    get "get_strategy_users", to: "strategies#get_strategy_users", as: :get_strategy_users
    post "create_user_strategy", to: "strategies#create_user_strategy", as: :create_user_strategy
    get "get_strategy_teams", to: "strategies#get_strategy_teams", as: :get_strategy_teams
    post "create_team_strategy", to: "strategies#create_team_strategy", as: :create_team_strategy
    get "destroy_user_strategy", to: "strategies#destroy_user_strategy", as: :destroy_user_strategy
    get "destroy_team_strategy", to: "strategies#destroy_team_strategy", as: :destroy_team_strategy
    put "update_strategy_user", to: "strategies#update_strategy_user", as: :update_strategy_user
  end

  scope :tactics do
    get "new_tactic_attachment/:tactic_id", to: "tactics#new_tactic_attachment", as: :new_tactic_attachment
    get "get_tactic_users", to: "tactics#get_tactic_users", as: :get_tactic_users
    post "create_user_tactic", to: "tactics#create_user_tactic", as: :create_user_tactic
    get "get_tactic_teams", to: "tactics#get_tactic_teams", as: :get_tactic_teams
    post "create_team_tactic", to: "tactics#create_team_tactic", as: :create_team_tactic
    get "destroy_user_tactic", to: "tactics#destroy_user_tactic", as: :destroy_user_tactic
    get "destroy_team_tactic", to: "tactics#destroy_team_tactic", as: :destroy_team_tactic
    put "update_tactic_user", to: "tactics#update_tactic_user", as: :update_tactic_user
  end
  
  get "strategic_plan", to: "plans#strategic_plan", as: :strategic_plan
  
  scope :strategic_plan do
    resources :plans, only: [:show] do
      resources :divisions, only: [:show] do
        resources :departments, only: [:show] do
          resources :areas, only: [:show] do
            resources :goals do 
              resources :objectives do
                resources :strategies do
                  resources :tactics
                end
              end
            end
          end
        end
      end
    end 
  end

   root to: 'dashboards#dashboard_1'

   # All routes
   get "dashboards/dashboard_1"
   get "dashboards/dashboard_2"
   get "dashboards/dashboard_3"
   get "dashboards/dashboard_4"
   get "dashboards/dashboard_4_1"
   get "dashboards/dashboard_5"
   get "dashboards/coming_soon"

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
