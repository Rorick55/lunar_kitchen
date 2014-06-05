require_relative 'ingredient'

class Recipe
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

  def self.all
    recipes = []
      query = self.db_connection do |conn|
        conn.exec("SELECT * FROM recipes ORDER BY name;")
      end
       query.each do |recipe|
        new_recipe = self.new(recipe['id'], recipe['name'], recipe['instructions'], recipe['description'])
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
