defmodule PostbitsWeb.BlogControllerTest do
  use PostbitsWeb.ConnCase

  describe "GET /blog" do
    test "renders the blog index page with centered card layout", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "Listing all posts"
      assert response =~ "max-w-7xl mx-auto"
      assert response =~ "text-center"
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

    test "displays list of all tags as clickable links", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "Tags:"
      assert response =~ "badge-outline hover:badge-primary"
      assert response =~ "href=\"/blog?tag="
    end

    test "displays All tag link that is selected by default", %{conn: conn} do
      conn = get(conn, ~p"/blog")
      response = html_response(conn, 200)

      assert response =~ "All"
      assert response =~ "badge-primary"
    end

    test "filters posts by tag when tag parameter is provided", %{conn: conn} do
      conn = get(conn, ~p"/blog?tag=hello")
      response = html_response(conn, 200)

      assert response =~ "Listing all posts"
      assert response =~ "Hello world!"
    end

    test "highlights selected tag", %{conn: conn} do
      conn = get(conn, ~p"/blog?tag=hello")
      response = html_response(conn, 200)

      assert response =~ "badge-primary"
    end
  end

  describe "GET /blog/:id" do
    test "renders individual blog post with centered layout", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "Hello world!"
      assert response =~ "max-w-4xl mx-auto"
      assert response =~ "<article"
    end

    test "displays post in a card with proper styling", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "bg-base-200 rounded-lg shadow-xl"
      assert response =~ "prose prose-lg"
    end

    test "includes back link to blog index", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "Back to all posts"
      assert response =~ "href=\"/blog\""
    end

    test "displays post metadata with icons", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "<time>"
      assert response =~ "Ganesh Sarwate"
      assert response =~ "<svg"
    end

    test "displays tags as large badges", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "badge badge-primary badge-lg"
    end

    test "includes View All Posts button", %{conn: conn} do
      conn = get(conn, ~p"/blog/hello-world")
      response = html_response(conn, 200)

      assert response =~ "View All Posts"
      assert response =~ "btn btn-primary"
    end

    test "returns 404 for non-existent post", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, ~p"/blog/non-existent-post")
      end
    end
  end
end
