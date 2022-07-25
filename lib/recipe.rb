class Recipe
  attr_reader :name, :description, :rating

  def initialize(attrs = {})
    @name = attrs[:name]
    @description = attrs[:description]
    @rating = attrs[:rating] || 0 # Default to 0
    @done = attrs[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done! # changes the object
    @done = true
  end
end
