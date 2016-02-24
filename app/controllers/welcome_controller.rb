class WelcomeController < ApplicationController
  include FactualWrapper

  def index
    @results = get_product
  end
end
