require_relative "recipe"
require "open-uri"
require "nokogiri"

# Scrape All Recipes
class AllRecipesScraper
  def initialize(query)
    @query = query
  end

  # When CALLED, it will scrape given query, and return Recipes
  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@query}"
    # URI load the url
    html_string = URI.open(url).read
    # Parse with Nokogiri
    doc = Nokogiri::HTML.parse(html_string)
    # Get the elements with the recipe data
    doc.search('.card__detailsContainer').first(5).map do |element|
      name = element.at('.card__titleLink').text.strip
      description = element.at('.card__summary').text.strip
      rating = element.search(".rating-star.active").count
      Recipe.new(name: name, description: description, rating: rating)
    end
  end
end
