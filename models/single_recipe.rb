require_relative 'ingredient'
require_relative 'single_ingredient'
require_relative 'recipe'

class SingleRecipe
  attr_reader :id, :name
  def initialize(id, name, instructions, description)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
  end

  def instructions
    if @instructions == nil
      answer = "This recipe doesn't have any instructions."
    else
      @instructions
    end
  end

  def description
    if @description == nil
      answer = "This recipe doesn't have a description."
    else
      @description
    end
  end

  def ingredients
    all_ingredients = []
    Ingredient.all.each do |ingredient|
      if ingredient.recipe_id == @id
        all_ingredients << ingredient
      end
    end
    all_ingredients
  end
end
