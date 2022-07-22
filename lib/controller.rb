require_relative "recipe"
require_relative "view"

# SRP - Single Responsability Principle
class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Ask REPO for all recipes
    recipes = @cookbook.all
    # 2. Ask VIEW to display them
    @view.display(recipes)
  end

  def destroy
    # Ask REPO for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
    # Ask VIEW to ask user for a index
    recipe_index = @view.ask_for_index
    # Ask REPO to remove that recipe
    @cookbook.remove_recipe(recipe_index)
  end

  def create
    # Ask VIEW to ask user for a name
    recipe_name = @view.ask_for_string("name")
    # Ask VIEW to ask user for a description
    recipe_description = @view.ask_for_string("description")
    # Ask MODEL to initialize a recipe
    new_recipe = Recipe.new(recipe_name, recipe_description)
    # Ask REPO to store it
    @cookbook.add_recipe(new_recipe)
  end
end
