require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password" )
    @user.save
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "new article", description: "this is a new article"}, user: @user }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "new article", response.body
  end

  test "get new article form and reject invalid entry" do
    get "/articles/new"
    assert :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: " "} }
    end
    assert_match "errors", response.body
  end

end