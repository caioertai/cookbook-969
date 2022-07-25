class View
  def display(recipes)
    # recipes => Array of Instances of Recipe
    recipes.each_with_index do |recipe, index|
      # recipe => Recipe Instance
      # I need to turn recipe rating into an integer
      box = recipe.done? ? "[X]" : "[ ]"
      puts "#{box} - #{index + 1}. #{recipe.name} (#{"*" * recipe.rating}) - #{recipe.description}"
    end
  end

  def ask_for_string(label)
    puts "What's the #{label}?"
    return gets.chomp
  end

  def ask_for_integer(label)
    puts "What's the #{label}?"
    return gets.chomp.to_i
  end

  def ask_for_index
    puts "Which recipe? (type the number)"
    gets.chomp.to_i - 1
  end
end
