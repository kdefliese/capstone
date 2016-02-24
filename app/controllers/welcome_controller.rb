class WelcomeController < ApplicationController
  include FactualWrapper

  def index
    @results = get_schema
  end
end
