# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Destroying everything

    Step.destroy_all
    RecipeStep.destroy_all
    RecipeIngredient.destroy_all
    Ingredient.destroy_all
    Recipe.destroy_all
    User.destroy_all
    UserRecipe.destroy_all
    Relationship.destroy_all

# Ingredients, Recipes, RecipeIngredients, Steps, and RecipeSteps

    quantities = [0.25, 1, 4, 3, 0.5, 0.75, 2]

    units = ['teaspoon', 'tablespoon', 'cup', 'pound', 'pint', 'ounce']

    categories = ['meat', 'vegetable', 'fruit', 'spice', 'dairy']

    recipe_categories = ['casserole', 'salad', 'baked', 'fried', 'raw', 'sushi', 'asian', 'seafood', 'grilled', 'mexican', 'african']

    steps = ['first', 'second', 'third', 'fourth', 'fifth']

    15.times do
        ingredient = Ingredient.create(name: Faker::Food.ingredient, category: categories[rand(0..4)], quantity: quantities[rand(0...7)], units: units[rand(0..5)])
        recipe = Recipe.create(title: Faker::Food.dish, category: recipe_categories[rand(0..10)])
        RecipeIngredient.create(recipe_id: recipe.id , ingredient_id: ingredient.id )
        step = Step.create(description: steps[rand(0..4)])
        RecipeStep.create(recipe_id: recipe.id, step_id: step.id)
    end


# Users and UserRecipes

    15.times do
        user = User.create(username: Faker::Twitter.screen_name, password_hash: Faker::String.random, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: rand(18..105))
        UserRecipe.create(user_id: user.id, recipe_id: Recipe.all.sample.id)
    end

# Relationships

    15.times do
        Relationship.create(follower_id: User.all.sample.id, followed_id: User.all.sample.id)

    end

