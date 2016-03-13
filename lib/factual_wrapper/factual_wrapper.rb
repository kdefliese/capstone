require 'factual'

module FactualWrapper

  def get_product_names(search_term)
    # should return format like: {"avg_price"=>4.22, "brand"=>"Triscuit", "calcium"=>0, "calories"=>120, "category"=>"Snacks", "cholesterol"=>0, "dietary_fiber"=>3, "ean13"=>"0044000027995", "factual_id"=>"b7619e09-77fd-4a06-8810-cce4fbcf53d4", "fat_calories"=>40, "image_urls"=>["http://content.shoprite.com/legacy/productimagesroot/DJ/5/1004195.jpg", "http://i.walmartimages.com/i/p/00/04/40/00/02/0004400002799_300X300.jpg", "http://media.itemmaster.com/0/0/0/835/38f2df5a-6b25-4292-ac4d-c2fb3b8ab50f.jpg?originalFormat=png", "http://media.shopwell.com/gladson/00044000027995_full.jpg", "http://www.homelandstores.com/pd/Content/themes/1F38368/images/applogo.png", "http://www.shopfoodex.com/images/00044000000806.gif"], "ingredients"=>["Whole Grain Soft White Wheat", "Soybean Oil", "Maltodextrin", "Salt", "Garlic Powder", "Dextrose", "Hydrolyzed Corn Protein", "Cornstarch", "Yeast Extract", "Hydrolyzed Yeast Protein", "Natural Flavor", "Hydrolyzed Wheat Protein", "Disodium Inosinate", "Disodium Guanylate (Flavor Enhancers)"], "iron"=>8, "manufacturer"=>"Nabisco", "monounsat_fat"=>1, "polyunsat_fat"=>2.5, "potassium"=>110, "product_name"=>"Crackers", "protein"=>3, "sat_fat"=>0.5, "serving_size"=>"6 crackers", "servings"=>9, "size"=>["9 oz"], "sodium"=>135, "sugars"=>0, "total_carb"=>20, "total_fat"=>4.5, "trans_fat"=>0, "upc"=>"044000027995", "vitamin_a"=>0, "vitamin_c"=>0}
    @factual = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])
    @factual.table("products-cpg-nutrition").search(search_term).filters("$or" => [
      {"category" => {"$eq" => "Alcoholic Beverages"}},
      {"category" => {"$eq" => "Baking Ingredients"}},
      {"category" => {"$eq" => "Baking Products"}},
      {"category" => {"$eq" => "Beans"}},
      {"category" => {"$eq" => "Beverages"}},
      {"category" => {"$eq" => "Bread"}},
      {"category" => {"$eq" => "Breakfast Foods"}},
      {"category" => {"$eq" => "Butters"}},
      {"category" => {"$eq" => "Cakes"}},
      {"category" => {"$eq" => "Candy"}},
      {"category" => {"$eq" => "Canned Food"}},
      {"category" => {"$eq" => "Canned Fruits and Vegetables"}},
      {"category" => {"$eq" => "Cheeses"}},
      {"category" => {"$eq" => "Chips"}},
      {"category" => {"$eq" => "Chocolate"}},
      {"category" => {"$eq" => "Condiments"}},
      {"category" => {"$eq" => "Cookies"}},
      {"category" => {"$eq" => "Crackers"}},
      {"category" => {"$eq" => "Crusts, Shells, Stuffing"}},
      {"category" => {"$eq" => "Dairy and Dairy-Substitute Products"}},
      {"category" => {"$eq" => "Dessert Toppings"}},
      {"category" => {"$eq" => "Dips"}},
      {"category" => {"$eq" => "Drink Mixers"}},
      {"category" => {"$eq" => "Drink Mixes"}},
      {"category" => {"$eq" => "Eggs"}},
      {"category" => {"$eq" => "Energy Drinks"}},
      {"category" => {"$eq" => "Extracts, Herbs & Spices"}},
      {"category" => {"$eq" => "Flours"}},
      {"category" => {"$eq" => "Food"}},
      {"category" => {"$eq" => "Frozen Foods"}},
      {"category" => {"$eq" => "Fruit Snacks"}},
      {"category" => {"$eq" => "Fruits"}},
      {"category" => {"$eq" => "Garlic"}},
      {"category" => {"$eq" => "Gourmet Food Gifts"}},
      {"category" => {"$eq" => "Grains"}},
      {"category" => {"$eq" => "Granola Bars"}},
      {"category" => {"$eq" => "Honey"}},
      {"category" => {"$eq" => "Hot Cocoa"}},
      {"category" => {"$eq" => "Ice Cream & Frozen Desserts"}},
      {"category" => {"$eq" => "Jams & Jellies"}},
      {"category" => {"$eq" => "Juices"}},
      {"category" => {"$eq" => "Lentils"}},
      {"category" => {"$eq" => "Meat Alternatives"}},
      {"category" => {"$eq" => "Meat, Poultry, Seafood Products"}},
      {"category" => {"$eq" => "Milk & Milk Substitutes"}},
      {"category" => {"$eq" => "Noodles & Pasta"}},
      {"category" => {"$eq" => "Nutritional Bars, Drinks, and Shakes"}},
      {"category" => {"$eq" => "Nuts"}},
      {"category" => {"$eq" => "Olives"}},
      {"category" => {"$eq" => "Packaged Foods"}},
      {"category" => {"$eq" => "Party Mix"}},
      {"category" => {"$eq" => "Pastries, Desserts & Pastry Products"}},
      {"category" => {"$eq" => "Popcorn"}},
      {"category" => {"$eq" => "Prepared Meals"}},
      {"category" => {"$eq" => "Popcorn"}},
      {"category" => {"$eq" => "Pudding"}},
      {"category" => {"$eq" => "Rice"}},
      {"category" => {"$eq" => "Salad Dressings"}},
      {"category" => {"$eq" => "Salsas"}},
      {"category" => {"$eq" => "Sauces"}},
      {"category" => {"$eq" => "Seasonings"}},
      {"category" => {"$eq" => "Soda"}},
      {"category" => {"$eq" => "Soups & Stocks"}},
      {"category" => {"$eq" => "Sugars & Sweeteners"}},
      {"category" => {"$eq" => "Syrups"}},
      {"category" => {"$eq" => "Tea & Coffee"}},
      {"category" => {"$eq" => "Vegetables"}},
      {"category" => {"$eq" => "Vinegars"}},
      {"category" => {"$eq" => "Vitamins & Supplements"}},
      {"category" => {"$eq" => "Water"}},
      {"category" => {"$eq" => "Weight Loss Products & Supplements"}},
      {"category" => {"$eq" => "Wheat Flours & Meals"}},
      {"category" => {"$eq" => "Yogurt"}}
    ]).rows
  end

  def get_product_names_from_barcode(code)
    @factual = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])
    @factual.table("products-cpg-nutrition").search(code).rows
  end

  def get_product_info(factual_id)
    @factual = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])
    @factual.table("products-cpg-nutrition").row(factual_id)
  end

end
