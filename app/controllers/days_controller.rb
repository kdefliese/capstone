class DaysController < ApplicationController

  def show
    @day = Day.find(params[:id])
    @entry = Entry.new
  end

end
