class Recipe
  attr_reader :name, :description

  def initialize(name, description)
    @name = name # instance variable
    @description = description
  end
end
