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

    scope "/users-characters" do
      get "/all", UserController, :get_all_user
      get "/:device_client_id", UserController, :get_user
      post "/new", UserController, :create_user
      put "/:device_client_id/edit", UserController, :update_selected_character
      get "/:device_client_id/get_units/", UserController, :get_units
      put "/:device_client_id/select_unit/:unit_id", UserController, :add_selected_unit
      put "/:device_client_id/unselect_unit/:unit_id", UserController, :remove_selected_unit
    end

    get "/autobattle/:device_client_id/:target_user_id", AutobattleController, :run_battle
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
