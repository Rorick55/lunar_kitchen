class SingleRecipe
  def initialize(id, name, instructions, description)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
  end

  def id
    @id
  end

  def name
    @name
  end
end


 class Recipe
  def initialize
    @recipes = []
    query = self.db_connection do |conn|
      conn.exec("SELECT name, id FROM recipes WHERE description IS NOT NULL ORDER BY name;")
    end
      query.each do |recipe|
        id = recipe['id']
        name = recipe['name']
        instructions = recipe['instructions']
        description = recipe['description']
        new_recipe = SingleRecipe.new(id, name, instructions, description)
        @recipes << new_recipe
      end
  end


  def self.all
    @recipes
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
end
