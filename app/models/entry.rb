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
      first_food = @entry.meals[0].foods[0]
      @print_italics = first_food.name
    elsif @entry.meals.empty?
      if !@entry.foods.empty?
        @print_italics = @entry.foods[0].name
      elsif @entry.foods.empty?
        @print_italics = @entry.ingredients[0].name
      end
    end
  end

end
