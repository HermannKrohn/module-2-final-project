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
    
    pictures = ['https://images.unsplash.com/photo-1506354666786-959d6d497f1a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80', 'https://images.unsplash.com/photo-1529042410759-befb1204b468?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80', 'https://images.unsplash.com/photo-1453831362806-3d5577f014a4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2577&q=80', 'https://images.unsplash.com/photo-1504185945330-7a3ca1380535?ixlib=rb-1.2.1&auto=format&fit=crop&w=642&q=80', 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=987&q=80', 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80', 'https://images.unsplash.com/photo-1532768641073-503a250f9754?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80']

    15.times do
        ingredient = Ingredient.create(name: Faker::Food.ingredient, category: categories[rand(0..4)], quantity: quantities[rand(0...7)], units: units[rand(0..5)])
        recipe = Recipe.create(title: Faker::Food.dish, category: recipe_categories[rand(0..10)], picture_url: pictures[rand(0..7)])
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

