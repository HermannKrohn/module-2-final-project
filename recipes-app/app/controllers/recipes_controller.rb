class RecipesController < ApplicationController

    skip_before_action :verify_authenticity_token  

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def create
        # byebug
        Recipe.create(recipe_params)

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