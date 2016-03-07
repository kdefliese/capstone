class DaysController < ApplicationController
  before_action :current_user
  before_action :current_day_for_user

  def show
    # need to make sure this method only shows entries and symptoms for that user on that day
    @day = Day.find(params[:id])
    @day_id = @day.id
    @user_id = @current_user.id
    @entries = @current_user.entries.where("day_id = ?", @day_id).order("time")
    @entry = Entry.new
    @all_meals = @current_user.meals.order("name")
    @all_foods = Food.all
    @all_ingredients = Ingredient.all
    @symptom = Symptom.new
    @symptoms = @current_user.symptoms.where("day_id = ?", @day_id)
  end

  def summary
    @day = Day.find(params[:id])
    @entries = @current_user.entries.where("day_id = ?", @day_id).order("time")
    @entries.each do |e|

    end
    return_obj = {
      "entries": [
        "e1": {
          "category":"Breakfast",
          "time":"2016-03-03 05:00:00",
          "notes":"These are my notes",
          "meal1": {
            "name": "Turkey Tacos",
            "foods": [
              {"name": "Amy's Refried Beans",
              "ingredients": [
                {"name": "Pinto beans"},
                {"name": "Pork lard"}
                ]
              },
              {"name": "Tostitos Tortillas",
              "ingredients": [
                {"name": "Flour"}
                ]
              },
              {"name": "El Paso Taco Seasoning",
              "ingredients": [
                {"name": "Cumin"},
                {"name": "Chili peppers"}
              ]
            }
          ]}
        }
      ]
    }
    render :json => return_obj.as_json, :status => :ok
  end



  private

  def day_params
    params.permit(:day, :user_id)
  end


end
