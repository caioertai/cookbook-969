require "csv"
require_relative "recipe"

class Cookbook # repository
  def initialize(csv_path)
    @recipes = [] # Instance variable
    @csv_path = csv_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    update_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    update_csv
  end

  private

  def load_csv
    # Hidration / Deserialization / Parsing
    CSV.foreach(@csv_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      @recipes.each do |recipe|
        # Dehidration / Serialization / Storing
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
