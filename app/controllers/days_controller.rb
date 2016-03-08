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

  def summary_alt
    @day = Day.find(params[:id])
    @day_id = @day.id
    return_obj = @current_user.entries.where("day_id = ?", @day_id).order("time").as_json(include: { meals: {
        only: [:name],
        include: { foods: {
          only: [:name],
          include: { ingredients: {
            only: [:name]
            }}
          }}
        }}
      )
    render :json => return_obj.as_json, :status => :ok
  end

  def summary
    @day = Day.find(params[:id])
    @day_id = @day.id
    return_obj = {
      "entries": []
    }
    @entries = @current_user.entries.where("day_id = ?", @day_id).order("time")
    entry_index = 0
    @entries.each do |e|
      return_obj[:entries].push(
      {"entry": {
        "id": e.id.to_s,
        "category": e.category,
        "time": e.time,
        "notes": e.notes,
        "meals": [],
        "foods": [],
        "ingredients": []
      }}
      )
      if !e.meals.empty?
        meal_index = 0
        e.meals.each do |m|
          return_obj[:entries][entry_index][:entry][:meals].push(
          {
            "name": m.name,
            "foods": []
          },
          )
          if !m.foods.empty?
            food_index = 0
            m.foods.each do |f|
              return_obj[:entries][entry_index][:entry][:meals][meal_index][:foods].push(
              {"name": f.name,
                "ingredients": []
                },
              )
              if !f.ingredients.empty?
                f.ingredients.each do |i|
                  return_obj[:entries][entry_index][:entry][:meals][meal_index][:foods][food_index][:ingredients].push(
                  {"name": i.name},
                  )
                end
              end
              food_index += 1
            end
          end
          meal_index += 1
        end
      end
      entry_index += 1
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
    render :json => return_obj.as_json, :status => :ok
  end



  private

  def day_params
    params.permit(:day, :user_id)
  end


end
