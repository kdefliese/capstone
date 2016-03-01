class IngredientsController < ApplicationController

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params[:ingredient])
    if @ingredient.save
      redirect_to ingredient_path(@ingredient)
    else
      render "new"
    end
  end

  def show
    id = params[:id]
    @ingredient = Ingredient.find(id)
  end

  def all
    render :json => Ingredient.order("name").as_json, :status => :ok
  end

  private

  def ingredient_params
    params.permit(ingredient:[:name, :sensitivity_groups])
  end

end
