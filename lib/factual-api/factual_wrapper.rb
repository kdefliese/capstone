require 'factual'

module FactualWrapper
  factualAPI = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])

  def get_schema
    factualAPI.table("products-cpg-nutrition").schema
  end

end
