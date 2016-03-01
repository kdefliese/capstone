class FoodsController < ApplicationController
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params[:food])
    if @food.save
      redirect_to food_path(@food)
    else
      render "new"
    end
  end

  def show
    id = params[:id]
    @food = Food.find(id)
  end

  def all
    render :json => Food.order("name").as_json, :status => :ok
  end

  private

  def food_params
    params.permit(food:[:brand, :name, :ingredients_list, :manufacturer, :category, :ean13, :upc, :factual_id, :image_urls, :sensitivity_groups])
  end
end
