require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: 'user1', email: 'email@example.com', password: 'password1')
    post login_url, params: { session: { username: 'user1', password: 'password1' } }
  end
  test 'should get index' do
    get users_url
    assert_response :success
  end

  # test 'should create user' do
  #   assert_difference('User.count') do
  #     post users_url,
  #          params: { user: { user: { username: 'user2', email: 'user2@example.com', password: 'password2' } } }
  #   end
  #
  #   assert_redirected_to user_url(User.last)
  # end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { user: { username: 'user1_edited' } }

    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_url
  end
end
