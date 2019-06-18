class IngredientsController < ApplicationController

    skip_before_action :verify_authenticity_token  


    def edit
        @ingredient = Ingredient.find(params[:id])
    end

    def show
        @ingredient = Ingredient.find(params[:id])
    end

    def create
        # byebug
        Ingredient.create(ingredient_params)
    end

    def update
        # byebug
        @ingredient = Ingredient.find(params[:id])
        @ingredient.update(ingredient_params)
    end

    def destroy
        
        @ingredient = Ingredient.find(params[:id])
        @ingredient.destroy
    
    end

    def ingredient_params
        params.permit(
            :name,
            :category,
            :quantity,
            :units
        )

    end

end