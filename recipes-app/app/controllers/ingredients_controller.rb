class IngredientsController < ApplicationController

    skip_before_action :verify_authenticity_token  


    def edit
        @ingredient = Ingredient.find(params[:id])
    end

    def update
        # byebug
        Ingredient.create(ingredient_params)

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