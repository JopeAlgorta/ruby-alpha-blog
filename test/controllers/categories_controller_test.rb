require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: 'user1', email: 'email@example.com', password: 'password1', admin: true)
    @user = User.create(username: 'user2', email: 'email@example.com', password: 'password1')
    @category = Category.create name: 'Sports'
  end

  test 'should get index' do
    get categories_url
    assert_response :success
  end

  test 'should get new' do
    login @admin_user
    get new_category_url
    assert_response :success
  end

  test 'should create category' do
    login @admin_user
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'category2' } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test 'should show category' do
    get category_url(@category)
    assert_response :success
  end

  test 'should get edit' do
    login @admin_user
    get edit_category_url(@category)
    assert_response :success
  end

  test 'should update category' do
    login @admin_user
    patch category_url(@category), params: { category: { name: 'edited_name' } }
    assert_redirected_to category_url(@category)
  end

  test 'should destroy category' do
    login @admin_user
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end

  test 'should not create category if not admin' do
    login @user
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: 'category2' } }
    end

    assert_redirected_to categories_url
  end
end
