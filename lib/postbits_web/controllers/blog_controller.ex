defmodule PostbitsWeb.BlogController do
  use PostbitsWeb, :controller

  alias Postbits.Blog

  def index(conn, params) do
    posts =
      case params["tag"] do
        nil -> Blog.all_posts()
        tag -> Blog.get_posts_by_tag!(tag)
      end

    render(conn, "index.html", posts: posts, tags: Blog.all_tags(), selected_tag: params["tag"])
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", post: Blog.get_post_by_id!(id))
  end
end
