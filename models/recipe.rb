require_relative 'ingredient'
require_relative 'single_ingredient'
require_relative 'single_recipe'

class Recipe

  def self.all
    recipes = []
      query = self.db_connection do |conn|
        conn.exec("SELECT * FROM recipes ORDER BY name;")
      end
       query.each do |recipe|
        new_recipe = SingleRecipe.new(recipe['id'], recipe['name'], recipe['instructions'], recipe['description'])
        recipes << new_recipe
      end
    recipes
  end

  def self.db_connection
    begin
      connection = PG.connect(dbname: 'recipes')
      yield(connection)
    ensure
      connection.close
    end
  end

  def each
    self.all.each
  end

  def self.find(id)
    found = nil
    self.all.each do |recipe|
      if recipe.id == id
        found = recipe
      end
    end
    found
  end
end
