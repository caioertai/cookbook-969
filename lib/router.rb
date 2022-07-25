# Directs user intention to the relevant controller action
class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    while @running do
      display_menu
      dispatch
    end
  end

  private

  def display_menu
    puts "-----------"
    puts '1. List recipes'
    puts '2. Add recipe'
    puts '3. Remove recipe'
    puts '4. Mark as done'
    puts '0. Quit'
  end

  def dispatch
    user_input = gets.chomp.to_i
    print `clear`
    case user_input
    when 1 then @controller.list # index
    when 2 then @controller.create
    when 3 then @controller.destroy
    when 4 then @controller.mark
    when 0 then @running = false
    end
  end
end
