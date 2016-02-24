require 'factual'

module FactualWrapper
  factual = Factual.new(ENV["FACTUAL_OAUTH_KEY"], ENV["FACTUAL_OAUTH_SECRET"])

  def get_schema
    factual.table("products-cpg-nutrition").schema
  end

end
