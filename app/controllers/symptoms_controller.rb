class SymptomsController < ApplicationController

  def create
    date = Day.find(params[:day_id]).day.to_s.slice(0,10)
    symptom_start_time = params[:start_time]
    symptom_start_datetime = DateTime.parse(date + " " + symptom_start_time)
    symptom_end_time = params[:end_time]
    if symptom_end_time != ""
      symptom_end_datetime = DateTime.parse(date + " " + symptom_end_time)
    else
      symptom_end_datetime = ""
    end
    @symptom = Symptom.new(symptom_params)
    @symptom.start_time = symptom_start_datetime
    @symptom.end_time = symptom_end_datetime
    if @symptom.save
      redirect_to day_path(Day.find(params[:day_id]))
    end
  end

  def last
    symptom = Symptom.last
    symptom_start_time = symptom.start_time.strftime("%l:%M %p")
    if symptom.end_time.nil?
      symptom_end_time = ""
    else
      symptom_end_time = symptom.end_time.strftime("%l:%M %p")
    end
    render :json => {:symptom => symptom.as_json, :symptom_start_time => symptom_start_time.as_json, :symptom_end_time => symptom_end_time.as_json}, :status => :ok
  end

  private

  def symptom_params
    params.permit(:name, :severity, :start_time, :end_time, :notes, :user_id, :day_id)
  end
end
