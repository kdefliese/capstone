class EntriesController < ApplicationController

  def create
    @entry = Entry.new(entry_params[:entry])
    if @entry.save
      redirect_to day_path(Day.find(1))
    else

    end
  end

  private

  def entry_params
    params.permit(entry:[:time, :category, :notes])
  end

end
