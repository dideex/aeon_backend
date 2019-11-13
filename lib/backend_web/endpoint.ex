defmodule BackendWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :backend
  use Absinthe.Phoenix.Endpoint

  socket("/guest", Backend.GuestSocket,
    websocket: true,
    longpoll: false
  )

  socket("/user", Backend.UserSocket,
    websocket: true,
    longpoll: false
  )

  plug CORSPlug

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug(Plug.Session,
    store: :cookie,
    key: "_backend_key",
    signing_salt: "TFeypSEn"
  )

  plug(BackendWeb.Router)
end
