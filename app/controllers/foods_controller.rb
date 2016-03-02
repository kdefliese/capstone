class FoodsController < ApplicationController
  include FactualWrapper

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

  def factual_search
    results = get_product_names(params[:term])
    return_data = []
    results.each do |r|
      return_data.push("#{r["brand"]} #{r["product_name"]}")
    end
    render :json => return_data.as_json, :status => :ok
  end

  def factual_search_specific_product
    results = get_product_info(params[:search_term])[0]
    # save this product to the DB now if it's not already in there
    if (Food.find_by factual_id: results["factual_id"]).nil?
      @food = Food.create(
      brand: results["brand"],
      name: results["product_name"],
      ingredients_list: results["ingredients"],
      manufacturer: results["manufacturer"],
      category: results["category"],
      ean13: results["ean13"],
      upc: results["upc"],
      factual_id: results["factual_id"],
      image_urls: results["image_urls"]
      )
      # create ingredients in the db for all of the ingredients if they don't exist
      @food.ingredients_list.each do |i|
        if (Ingredient.find_by name: i).nil?
          Ingredient.create(name: i)
        end
      end
    end
    render :json => results.as_json, :status => :ok
  end



  private

  def food_params
    params.permit(food:[:brand, :name, :ingredients_list, :manufacturer, :category, :ean13, :upc, :factual_id, :image_urls, :sensitivity_groups])
  end
end
