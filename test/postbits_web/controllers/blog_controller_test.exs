defmodule PostbitsWeb.BlogControllerTest do
  use PostbitsWeb.ConnCase

  describe "GET /blog" do
    test "renders the blog index page with card layout", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "Listing all posts"
      assert response =~ "grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
    end

    test "displays blog posts as cards with proper daisyUI classes", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "card bg-base-200 shadow-xl"
      assert response =~ "hover:shadow-2xl"
      assert response =~ "card-body"
      assert response =~ "card-title"
    end

    test "displays post metadata (date, author)", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "<time>"
      assert response =~ "by"
    end

    test "displays tags as badges", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "badge badge-primary"
      assert response =~ "card-actions"
    end

    test "entire card is a clickable link to the blog post", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "href=\"/blog/"
      assert response =~ "cursor-pointer"
      assert response =~ "no-underline"
    end
  end

  describe "GET /blog/:id" do
    test "renders individual blog post", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "Hello world!"
    end

    test "returns 404 for non-existent post", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, ~p"/blog/non-existent-post")
      end
    end
  end
end
