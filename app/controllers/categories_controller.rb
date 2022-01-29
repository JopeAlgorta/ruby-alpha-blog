# frozen_string_literal: true

# Category Controller
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :require_admin_user, except: %i[index show]

  def new
    @category = Category.new
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to @category, notice: 'Category created successfully!'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update category_params
      redirect_to @category, notice: 'Category updated successfully!'
    else
      render 'edit'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 18)
  end

  def destroy
    redirect_to categories_path if @category.destroy
  end

  private

  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin_user
    unless logged_in? && current_user.admin?
      redirect_to categories_path,
                  alert: 'Only admin users can perform this action.'
    end
  end
end
