class SymptomsController < ApplicationController

  def create
    date = Day.find(params[:day_id]).day.to_s.slice(0,10)
    symptom_start_time = params[:start_time]
    symptom_start_datetime = DateTime.parse(date + " " + symptom_start_time)
    symptom_end_time = params[:end_time]
    symptom_end_datetime = DateTime.parse(date + " " + symptom_end_time)
    @symptom = Symptom.new(symptom_params)
    @symptom.start_time = symptom_start_datetime
    @symptom.end_time = symptom_end_datetime
    if @symptom.save
      redirect_to day_path(Day.find(params[:day_id]))
    end
  end

  private

  def symptom_params
    params.permit(:name, :severity, :start_time, :end_time, :notes, :user_id, :day_id)
  end
end
