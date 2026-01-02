defmodule PostbitsWeb.PageController do
  use PostbitsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
