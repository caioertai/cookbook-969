require_relative "lib/recipe"
require_relative "lib/cookbook"

cookbook = Cookbook.new("lib/recipes.csv")

p cookbook.all
