class SymptomsController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

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

  def edit
    @symptom = Symptom.find(params[:id])
    @day_id = @symptom.day_id
    @user_id = @current_user.id
    # need to convert to military time because HTML time form field only accepts 24 hour clock
    @start_time = @symptom.military_conversion(params[:id],"start_time")
    if @symptom.end_time?
      @end_time = @symptom.military_conversion(params[:id],"end_time")
    end
  end

  def update
    @symptom = Symptom.find(params[:id])
    date = Day.find(params[:day_id]).day.to_s.slice(0,10)
    symptom_start_time = params[:start_time]
    symptom_start_datetime = DateTime.parse(date + " " + symptom_start_time)
    symptom_end_time = params[:end_time]
    if symptom_end_time != ""
      symptom_end_datetime = DateTime.parse(date + " " + symptom_end_time)
    else
      symptom_end_datetime = ""
    end
    @symptom.start_time = symptom_start_datetime
    @symptom.end_time = symptom_end_datetime
    @symptom.name = params[:name]
    @symptom.severity = params[:severity]
    @symptom.notes = params[:notes]
    @symptom.save
    render nothing: true
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    day_id = @symptom.day_id
    @symptom.destroy
    redirect_to day_path(day_id)
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
