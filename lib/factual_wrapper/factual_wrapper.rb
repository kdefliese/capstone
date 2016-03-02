require 'factual'

module FactualWrapper

  def get_product(search_term)
    # should return format like: {"avg_price"=>4.22, "brand"=>"Triscuit", "calcium"=>0, "calories"=>120, "category"=>"Snacks", "cholesterol"=>0, "dietary_fiber"=>3, "ean13"=>"0044000027995", "factual_id"=>"b7619e09-77fd-4a06-8810-cce4fbcf53d4", "fat_calories"=>40, "image_urls"=>["http://content.shoprite.com/legacy/productimagesroot/DJ/5/1004195.jpg", "http://i.walmartimages.com/i/p/00/04/40/00/02/0004400002799_300X300.jpg", "http://media.itemmaster.com/0/0/0/835/38f2df5a-6b25-4292-ac4d-c2fb3b8ab50f.jpg?originalFormat=png", "http://media.shopwell.com/gladson/00044000027995_full.jpg", "http://www.homelandstores.com/pd/Content/themes/1F38368/images/applogo.png", "http://www.shopfoodex.com/images/00044000000806.gif"], "ingredients"=>["Whole Grain Soft White Wheat", "Soybean Oil", "Maltodextrin", "Salt", "Garlic Powder", "Dextrose", "Hydrolyzed Corn Protein", "Cornstarch", "Yeast Extract", "Hydrolyzed Yeast Protein", "Natural Flavor", "Hydrolyzed Wheat Protein", "Disodium Inosinate", "Disodium Guanylate (Flavor Enhancers)"], "iron"=>8, "manufacturer"=>"Nabisco", "monounsat_fat"=>1, "polyunsat_fat"=>2.5, "potassium"=>110, "product_name"=>"Crackers", "protein"=>3, "sat_fat"=>0.5, "serving_size"=>"6 crackers", "servings"=>9, "size"=>["9 oz"], "sodium"=>135, "sugars"=>0, "total_carb"=>20, "total_fat"=>4.5, "trans_fat"=>0, "upc"=>"044000027995", "vitamin_a"=>0, "vitamin_c"=>0}
    @factual = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])
    # ex of full text search, returns white cheddar cheez-its from ean13 barcode: @factual.table("products-cpg-nutrition").search("024100789382").rows
    # product_info = []
    # product_info.push(
    @factual.table("products-cpg-nutrition").search(search_term).rows
    #[0]["brand"]
    # )
    # product_info.push(@factual.table("products-cpg-nutrition").search(search_term).rows[0]["product_name"])
    # product_info.push(@factual.table("products-cpg-nutrition").search(search_term).rows[0]["ingredients"])
    # vreturn product_info
  end

end
