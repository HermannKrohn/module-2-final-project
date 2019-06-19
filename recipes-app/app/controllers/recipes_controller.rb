class RecipesController < ApplicationController

    skip_before_action :verify_authenticity_token  

    def new
        @recipes = Recipe.all
        if (flash[:form_errors])
            @errors = flash[:form_errors]
        else
            @recipes = Recipe.all
        end        

    end

    def show
    
    end
    
    def edit
        if(flash[:form_errors])
            @errors = flash[:form_errors]
        else
        @recipe = Recipe.find(params[:id])
        end

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
        if @recipe.valid?
            @recipe.save
            @userrecipe = UserRecipe.new(user_id: session[:user_id], recipe_id: @recipe.id)
            @userrecipe.save
            redirect_to "/index/#{session[:user_id]}"
        else
            flash[:form_errors] = @recipe.errors.messages
            redirect_to "/index/#{session[:user_id]}"
        end
    end

    def update
        # byebug

        @recipe = Recipe.find(params[:id])
        @recipe.assign_attributes(recipe_params)
        if @recipe.valid?
            @recipe.save
            redirect_to "/index/#{session[:user_id]}"
        else
            flash[:form_errors] = @recipe.errors.messages
            redirect_to "/recipes/#{@recipe.id}/edit"
        end

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