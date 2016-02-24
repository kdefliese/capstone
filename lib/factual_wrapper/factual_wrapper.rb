require 'factual'

module FactualWrapper

  def get_schema
    @factual = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])
    @factual.table("products-cpg-nutrition").schema
  end

end
