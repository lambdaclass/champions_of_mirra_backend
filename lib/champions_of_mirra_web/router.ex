defmodule ChampionsOfMirraWeb.Router do
  use ChampionsOfMirraWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ChampionsOfMirraWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChampionsOfMirraWeb do
    pipe_through :browser

    get "/", PageController, :home

    post "/users/new", UserController, :create_user

    scope "/users/:device_client_id/" do
      get "/", UserController, :get_user
      put "/edit", UserController, :update_selected_character

      get "/get_units/", UserController, :get_units
      put "/select_unit/:unit_id", UserController, :add_selected_unit
      put "/unselect_unit/:unit_id", UserController, :remove_selected_unit
    end

    scope "/battle/:device_client_id/" do
      get "/get_opponents", UserController, :get_opponents
      get "/pvp/:target_user_id", PvPController, :battle

      scope "/campaigns" do
        get "/", CampaignController, :get_campaigns
        get "/:campaign_id", CampaignController, :get_campaign
        get "/:campaign_id/levels/:level_id", CampaignController, :battle_level
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChampionsOfMirraWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:champions_of_mirra, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ChampionsOfMirraWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
