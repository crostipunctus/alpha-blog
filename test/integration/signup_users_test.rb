require "test_helper"

class SignupUsersTest < ActionDispatch::IntegrationTest

  test "get new user form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "John Doe", email: "johndoe@example.com", password: "password"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "John Doe", response.body
  end

  test "get new user form and reject invalid entry" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: " ", email: "johndoe.com", password: " "}}
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end



end