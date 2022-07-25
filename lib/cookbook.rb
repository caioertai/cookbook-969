require "pry-byebug"
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

  def persist!
    update_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # row => { name: "Pizza", description: "Flour and cheese", rating: "5" }
      # Data Type Casting
      # name        --- String
      # description --- String
      # rating      --- Integer
      # done        --- boolean (true/false)
      row[:rating] = row[:rating].to_i # => "5".to_i => 5
      row[:done]   = row[:done] == "true"

      # row => { name: "Pizza", description: "Flour and cheese", rating: 5 }

      @recipes << Recipe.new(row)
    end
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << ["name", "description", "rating", "done"]
      @recipes.each do |recipe|
        # Dehidration / Serialization / Storing
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?]
      end
    end
  end
end
