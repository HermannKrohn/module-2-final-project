class IngredientsController < ApplicationController

    skip_before_action :verify_authenticity_token  


    def edit
        if (flash[:form_errors])
            @errors = flash[:form_errors]
        end
        @ingredient = Ingredient.find(params[:id])
    end

    def show
        @ingredient = Ingredient.find(params[:id])
    end

    def create
        # byebug
        Ingredient.create(ingredient_params)
        redirect_to "/index/#{session[:user_id]}"
    end

    def update
        # byebug
        @ingredient = Ingredient.find(params[:id])
        @ingredient.assign_attributes(ingredient_params)
        if @ingredient.valid?
            @ingredient.save
            redirect_to "/index/#{session[:user_id]}"
        else
            flash[:form_errors] = @ingredient.errors.messages
            redirect_to "/ingredients/#{@ingredient.id}/edit"
        end
    end

    def increment_quantity
        @ingredient = Ingredient.find(params[:id])
        @ingredient.quantity += 0.25
        @ingredient.save
        redirect_to "/ingredients/#{@ingredient.id}/edit"
    end

    def decrement_quantity
        @ingredient = Ingredient.find(params[:id])
        @ingredient.quantity -= 0.25
        @ingredient.save
        redirect_to "/ingredients/#{@ingredient.id}/edit"
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