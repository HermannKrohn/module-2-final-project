class RecipesController < ApplicationController

    skip_before_action :verify_authenticity_token  

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def show
        @recipe = Recipe.find(params[:id])

        # ingredient_ids = RecipeIngredient.all.select do | recipe_ingredient |
        #     recipe_ingredient.recipe_id == @recipe.id
        # end.map do | recipe_ingredient |
        #     recipe_ingredient.ingredient_id
        # end

        # @ingredients = Ingredient.all.select do | ingredient |
        #     ingredient_ids.each do | ingredient_id |
        #         ingredient.id == ingredient_id
        #     end
        # end
    end

    def create
        # byebug
        @recipe = Recipe.new(recipe_params)
        @recipe.save
        @userrecipe = UserRecipe.new(user_id: session[:user_id], recipe_id: @recipe.id)
        @userrecipe.save
        redirect_to "/index/#{session[:user_id]}"

    end

    def update
        # byebug
        @recipe = Recipe.find(params[:id])
        @recipe.update(recipe_params)
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
    end

    def recipe_params
        params.permit(
            :title,
            :category        
        )

    end

end