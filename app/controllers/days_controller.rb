class DaysController < ApplicationController

  def show
    @day = Day.find(params[:id])
    @entries = @day.entries
    @entry = Entry.new
  end

end
