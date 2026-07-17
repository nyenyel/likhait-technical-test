class Api::CategoriesController < ApplicationController
  def index
    categories = Category.order(:name)
    render json: categories
  end

  def create
    categories = Category.new(categories_params)

    if categories.save
      render json: format_categories(categories), status: :created
    else
      render json: { errors: categories.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    categories = categories.find(params[:id])

    if categories.update(category_params)
      render json: format_categories(categories)
    else
      render json: { errors: categories.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    categories = categories.find(params[:id])
    categories.destroy
    head :no_content
  end

  private 

  def category_params
    params.require(:category).permit(:description, :amount, :category_id, :date)
  end

  def format_category(category)
    {
      id: category.id,
      name: category.name,
      created_at: category.created_at,
      updated_at: category.updated_at
    }
  end
end
