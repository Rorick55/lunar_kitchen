require_relative 'recipe'

class Ingredient
  attr_reader :id, :name, :recipe_id

  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end

  def self.all
    ingredients = []
    query = self.db_connection do |conn|
      conn.exec("SELECT * FROM ingredients;")
    end
    query.each do |ingredient|
      new_ingredient = self.new(ingredient['id'], ingredient['name'], ingredient['recipe_id'])
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


