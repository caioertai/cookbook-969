require_relative "all_recipes_scraper"
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
    # Ask VIEW to ask user for a rating
    recipe_rating = @view.ask_for_integer("rating")
    # Ask MODEL to initialize a recipe
    #                          1                  2
    #                 { name: "Something", description: "...", rating: 4 }
    # new_recipe = Recipe.new(recipe_name, recipe_description)
    new_recipe = Recipe.new({name: recipe_name, description: recipe_description, rating: recipe_rating})
    # Ask REPO to store it
    @cookbook.add_recipe(new_recipe)
  end

  def mark
    # Ask COOKBOOK for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display thems
    @view.display(recipes)
    # Ask VIEW to ask user for one to mark
    index = @view.ask_for_index
    # Get the recipe and mark it as changed
    recipe_to_mark = recipes[index]
    recipe_to_mark.mark_as_done! # Recipe Instance
    # Ask COOKBOOK to persist the change
    @cookbook.persist! # public method
  end

  def search
    # Ask VIEW to ask user for a query (search inputs)
    query = @view.ask_for_string("ingredient you're searching for")
    # Ask SCRAPER for a list of recipes
    recipes = AllRecipesScraper.new(query).call
    # Ask VIEW to display them
    @view.display(recipes)
    # Ask VIEW to ask user for a recipe to add (by number)
    index = @view.ask_for_index
    new_recipe = recipes[index]
    # Ask COOKBOOK to add it
    @cookbook.add_recipe(new_recipe)
  end
end
