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
    
    def edit
        if(flash[:form_errors])
            @errors = flash[:form_errors]
        else
        @recipe = Recipe.find(params[:id])
        end

    end

    def create
        # byebug

        @recipe = Recipe.new(recipe_params)
        if @recipe.valid?
            @recipe.save
        else
            flash[:form_errors] = @recipe.errors.messages
            redirect_to "/index/#{session[:id]}"
        end

    end

    def update
        # byebug

        @recipe = Recipe.find(params[:id])
        @recipe.assign_attributes(recipe_params)
        if @recipe.valid?
            @recipe.save
            redirect_to 
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