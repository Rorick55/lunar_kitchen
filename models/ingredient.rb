require_relative 'single_ingredient'
require_relative 'single_recipe'
require_relative 'recipe'

class Ingredient

  def self.all
    ingredients = []
    query = self.db_connection do |conn|
      conn.exec("SELECT * FROM ingredients;")
    end
    query.each do |ingredient|
      new_ingredient = SingleIngredient.new(ingredient['id'], ingredient['name'], ingredient['recipe_id'])
      ingredients << new_ingredient
    end
    ingredients
  end

  def self.db_connection
    begin
      connection = PG.connect(dbname: 'recipes')
      yield(connection)
    ensure
      connection.close
    end
  end

  def self.each
    self.all.each
  end
end


