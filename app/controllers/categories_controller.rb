# frozen_string_literal: true

# Category Controller
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def new
    @category = Category.new
  end

  def show; end

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

  def index; end

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
end
