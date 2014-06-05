require_relative 'ingredient'
require_relative 'single_recipe'
require_relative 'recipe'

class SingleIngredient
  attr_reader :id, :name, :recipe_id
  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end
end
