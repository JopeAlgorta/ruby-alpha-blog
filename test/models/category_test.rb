require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  CATEGORY_NAME = 'Sports'.freeze

  def setup
    @category = Category.new name: CATEGORY_NAME
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ''

    assert_not @category.valid?
    assert_not_equal(CATEGORY_NAME, @category.name)
  end

  test 'name should be unique' do
    @category.save

    @category2 = Category.new name: CATEGORY_NAME
    assert_not @category2.valid?
  end

  test 'name should not be too long' do
    @category.name = 'a' * 26

    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 'a' * 2

    assert_not @category.valid?
  end
end
