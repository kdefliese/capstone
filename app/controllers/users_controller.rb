class UsersController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    # need to do something with the three array fields here so they'll update properly
    binding.pry
    @user = User.update(params[:id], user_params)
    redirect_to user_path
  end

  def stats
  end

  def stats_endpoint
    @symptoms = @current_user.symptoms
    @symptom_arr = []
    pain = ["Pain",[]]
    gas = ["Gas",[]]
    diarrhea = ["Diarrhea",[]]
    constipation = ["Constipation",[]]
    headache = ["Headache/Migraine",[]]
    bloating = ["Bloating",[]]
    nausea = ["Nausea",[]]
    heartburn = ["Heartburn",[]]
    burping = ["Burping",[]]
    skin = ["Skin problems",[]]
    @symptoms.each do |s|
      if s.name == "Pain"
        pain[1].push([s.start_time,s.severity])
      elsif s.name == "Gas"
        gas[1].push([s.start_time,s.severity])
      elsif s.name == "Diarrhea"
        diarrhea[1].push([s.start_time,s.severity])
      elsif s.name == "Constipation"
        constipation[1].push([s.start_time,s.severity])
      elsif s.name == "Headache/Migraine"
        headache[1].push([s.start_time,s.severity])
      elsif s.name == "Bloating"
        bloating[1].push([s.start_time,s.severity])
      elsif s.name == "Nausea"
        nausea[1].push([s.start_time,s.severity])
      elsif s.name == "Heartburn"
        heartburn[1].push([s.start_time,s.severity])
      elsif s.name == "Burping"
        burping[1].push([s.start_time,s.severity])
      elsif s.name == "Skin Problems"
        skin[1].push([s.start_time,s.severity])
      end
    end
    if pain[1].length > 0
      @symptom_arr.push(pain)
    end
    if gas[1].length > 0
      @symptom_arr.push(gas)
    end
    if diarrhea[1].length > 0
      @symptom_arr.push(diarrhea)
    end
    if constipation[1].length > 0
      @symptom_arr.push(constipation)
    end
    if headache[1].length > 0
      @symptom_arr.push(headache)
    end
    if bloating[1].length > 0
      @symptom_arr.push(bloating)
    end
    if nausea[1].length > 0
      @symptom_arr.push(nausea)
    end
    if heartburn[1].length > 0
      @symptom_arr.push(heartburn)
    end
    if burping[1].length > 0
      @symptom_arr.push(burping)
    end
    if skin[1].length > 0
      @symptom_arr.push(skin)
    end
    render :json => @symptom_arr.as_json, :status => :ok
  end

  private

  def user_params
    params.permit(:id, :email, :phone, :name, :image, :notifications_preference, known_intolerances: [])
  end

  def make_stats_array(symptom_name)
    arr = ["#{symptom_name}",[]]
    symptoms = @current_user.symptoms.where("name = ?", symptom_name)
    symptoms.each do |s|
      arr[1].push([s.start_time,s.severity])
    end
    if arr[1].length > 0
      @symptom_arr.push(arr)
    end
  end

end
