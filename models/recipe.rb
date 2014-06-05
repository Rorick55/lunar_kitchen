class SingleRecipe
  attr_reader :id, :name, :instructions, :description
  def initialize(id, name, instructions, description)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
  end

  def ingredients

end


 class Recipe
  def self.all
    recipes = []
       query = self.db_connection do |conn|
      conn.exec("SELECT * FROM recipes WHERE description IS NOT NULL ORDER BY name;")
    end
       query.each do |recipe|
        id = recipe['id']
        name = recipe['name']
        instructions = recipe['instructions']
        description = recipe['description']
        new_recipe = SingleRecipe.new(id, name, instructions, description)
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
