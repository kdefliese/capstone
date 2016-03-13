class FoodsController < ApplicationController
  include FactualWrapper
  before_action :current_user
  before_action :current_day_for_user

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
      return_data.push(label: "#{r["brand"]} #{r["product_name"]}", value: "#{r["factual_id"]}")
    end
    render :json => return_data.as_json, :status => :ok
  end

  def factual_search_barcode
    results = get_product_names_from_barcode(params[:term].to_s)
    return_data = []
    results.each do |r|
      return_data.push(label: "#{r["brand"]} #{r["product_name"]}", value: "#{r["factual_id"]}")
    end
    render :json => return_data.as_json, :status => :ok
  end

  def factual_search_specific_product
    results = get_product_info(params[:factual_id])
    if !(Food.find_by factual_id: results["factual_id"]).nil?
      @food = Food.find_by factual_id: results["factual_id"]
    else
      # save this product to the DB since it's not already in there
      @food = Food.create(
      brand: results["brand"],
      name: results["brand"] + " " + results["product_name"],
      ingredients_list: results["ingredients"],
      manufacturer: results["manufacturer"],
      category: results["category"],
      ean13: results["ean13"],
      upc: results["upc"],
      factual_id: results["factual_id"],
      image_urls: results["image_urls"]
      )
      # if the food has listed ingredients, create ingredients in the db for ingredients that aren't already in the db
      if !@food.ingredients_list.nil?
        @food.ingredients_list.each do |i|
          food_exists = Ingredient.find_by name: i
          if food_exists.nil?
            @ingredient = Ingredient.create(name: i)
            @food.ingredients << @ingredient
          else
            @food.ingredients << food_exists
          end
        end
      end
    end

    render :json => @food.as_json, :status => :ok
  end



  private

  def food_params
    params.permit(food:[:brand, :name, :ingredients_list, :manufacturer, :category, :ean13, :upc, :factual_id, :image_urls, :sensitivity_groups])
  end
end
