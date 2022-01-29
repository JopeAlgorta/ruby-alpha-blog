require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: 'user1', email: 'email@example.com', password: 'password1', admin: true)
    @user = User.create(username: 'user2', email: 'email@example.com', password: 'password1')
  end

  test 'get new category form and create category' do
    login @admin_user
    get new_category_url
    assert_response :success

    assert_difference 'Category.count' do
      post categories_url, params: { category: { name: 'category1' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match 'category1', response.body
  end

  test 'get new category form and try create invalid category' do
    login @admin_user
    get new_category_url
    assert_response :success

    assert_no_difference 'Category.count' do
      post categories_url, params: { category: { name: '' } }
      assert_response :success
    end

    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    assert_match 'errors', response.body
  end
end
