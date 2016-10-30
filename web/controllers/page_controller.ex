defmodule TecLab_2.PageController do
  use TecLab_2.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
