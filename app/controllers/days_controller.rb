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
    @day_id = @day.id
    obj_2 = {
      "entries": []
    }
    @entries = @current_user.entries.where("day_id = ?", @day_id).order("time")
    @entries.each do |e|
      obj_2[:entries].push(
      {"entry": {
        "id": e.id.to_s,
        "category": e.category,
        "time": e.time,
        "notes": e.notes,
        "meals": [
          if !e.meals.empty?
            # this is going to cause a problem if there are multiple meals in an entry, there need to be commas inbetween them
            e.meals.each do |m|
              {
                "name": m.name,
                "foods": []
              }
            end
          end
          ]
      }}
      )
    end
    # return_obj = {
    #   "entries": [
    #     {"entry": {
    #       "id": "1",
    #       "category":"Breakfast",
    #       "time":"2016-03-03 05:00:00",
    #       "notes":"These are my notes",
    #       "meals": [{
    #         "name": "Turkey Tacos",
    #         "foods": [
    #           {"name": "Amy's Refried Beans",
    #           "ingredients": [
    #             {"name": "Pinto beans"},
    #             {"name": "Pork lard"}
    #             ]
    #           },
    #           {"name": "Tostitos Tortillas",
    #           "ingredients": [
    #             {"name": "Flour"}
    #             ]
    #           },
    #           {"name": "El Paso Taco Seasoning",
    #           "ingredients": [
    #             {"name": "Cumin"},
    #             {"name": "Chili peppers"}
    #           ]
    #         }
    #       ]}
    #     ]
    #     }},
    #     {"entry": {
    #       "id": "2",
    #       "category":"Breakfast",
    #       "time":"2016-03-03 05:00:00",
    #       "notes":"These are my notes",
    #       "meals": [{
    #         "name": "Breakfast Tacos",
    #         "foods": [
    #           {"name": "Amy's Refried Beans",
    #           "ingredients": [
    #             {"name": "Pinto beans"},
    #             {"name": "Pork lard"}
    #             ]
    #           },
    #           {"name": "Tostitos Tortillas",
    #           "ingredients": [
    #             {"name": "Flour"}
    #             ]
    #           },
    #           {"name": "El Paso Taco Seasoning",
    #           "ingredients": [
    #             {"name": "Cumin"},
    #             {"name": "Chili peppers"}
    #           ]
    #         }
    #       ]}
    #     ]
    #     }}
    #   ]
    # }
    render :json => obj_2.as_json, :status => :ok
  end



  private

  def day_params
    params.permit(:day, :user_id)
  end


end
