require_relative "lib/cookbook"
require_relative "lib/controller"
require_relative "lib/router"

cookbook = Cookbook.new("lib/recipes.csv") # this will get recipe instances from the CSV
controller = Controller.new(cookbook)
router = Router.new(controller)

router.run
