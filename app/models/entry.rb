class Entry < ActiveRecord::Base
  belongs_to :days
  belongs_to :users
  has_and_belongs_to_many :meals
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :ingredients

  def print_capitals(id)
    @entry = Entry.find(id)
    @print_caps = ""
    if !@entry.meals.empty? && @entry.meals.length <= 1
      @print_caps = @entry.meals[0].name
    elsif !@entry.meals.empty? && @entry.meals.length >= 2
      build_print_caps = ""
      @entry.meals.each do |m|
        build_print_caps += "#{m.name}, "
      end
      @print_caps = build_print_caps[0...-2]
    elsif @entry.meals.empty?
      @print_caps = nil
    end
  end

  def print_italics(id)
    @entry = Entry.find(id)
    @print_italics = ""
    if !@entry.meals.empty? && !@entry.meals[0].foods.empty?
      @print_italics = @entry.meals[0].foods[0].name
      if @entry.meals[0].foods.length >= 1
        @print_italics += ", #{@entry.meals[0].foods[1].name}"
      end
      @print_italics += "..."
    elsif @entry.meals.empty?
      if !@entry.foods.empty?
        @print_italics = @entry.foods[0].name
        if @entry.foods.length > 1
          @print_italics += " , #{@entry.foods[1].name}..."
        end
      elsif @entry.foods.empty? && !@entry.ingredients.empty?
        @print_italics = @entry.ingredients[0].name
        if @entry.ingredients.length > 1
          @print_italics += " , #{@entry.ingredients[1].name}..."
        end
      end
    end
    return @print_italics
  end

  def military_conversion(id)
    @entry = Entry.find(id)
    if @entry.time.strftime("%p") == "AM" && @entry.time.strftime("%l").to_i < 10
      @return_time = "0" + @entry.time.strftime("%l:%M").strip
    elsif time.strftime("%p") == "AM" && @entry.time.strftime("%l").to_i >= 10
      @return_time = @entry.time.strftime("%l:%M").strip
    else
      hour = @entry.time.strftime("%l").to_i
      if hour != 12
        military_hour = hour + 12
        @return_time = military_hour.to_s + ":" + @entry.time.strftime("%M")
      else
        @return_time = hour.to_s + ":" + @entry.time.strftime("%M")
      end
    end
    return @return_time
  end

end
