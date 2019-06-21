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

        @recipe = Recipe.new(recipe_params[:recipe])
        if @recipe.valid?
            @recipe.save
            @userrecipe = UserRecipe.new(user_id: session[:user_id], recipe_id: @recipe.id)
            @userrecipe.save

        else
            flash[:form_errors] = @recipe.errors.messages
            redirect_to "/index/#{session[:user_id]}"
        end

        i = 0
        while i < recipe_params[:ingredients][:names].length
            @ingredient = Ingredient.new(name: recipe_params[:ingredients][:names][i], category: recipe_params[:ingredients][:categories][i], quantity: recipe_params[:ingredients][:quantities][i], units: recipe_params[:ingredients][:units][i])
            if @ingredient.valid?
                @ingredient.save
                @recipeingredient = RecipeIngredient.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
                @recipeingredient.save
                i += 1
            else
                @recipe.destroy
                flash[:form_errors] = @ingredient.errors.messages
                redirect_to "/index/#{session[:user_id]}"
                return
            end
        end

        i = 0
        while i < recipe_params[:steps][:descriptions].length
            @step = Step.create(description: recipe_params[:steps][:descriptions][i])
            @recipestep = RecipeStep.new(recipe_id: @recipe.id, step_id: @step.id)
            @recipestep.save
            i += 1
        end

        redirect_to "/index/#{session[:user_id]}"

    end

    def update

        @recipe = Recipe.find(params[:id])
        @recipe.assign_attributes(recipe_params[:recipe])
        if @recipe.valid?
            @recipe.save
            # @userrecipe = UserRecipe.new(user_id: session[:user_id], recipe_id: @recipe.id)
            # @userrecipe.save
        else
            flash[:form_errors] = @recipe.errors.messages
            redirect_to "/recipes/#{@recipe.id}/edit"
            return
        end

        i = 0
        while i < recipe_params[:ingredients][:names].length
            @ingredient = @recipe.ingredients[i]
            @ingredient.assign_attributes(name: recipe_params[:ingredients][:names][i], category: recipe_params[:ingredients][:categories][i], quantity: recipe_params[:ingredients][:quantities][i], units: recipe_params[:ingredients][:units][i])
            if @ingredient.valid?
                @ingredient.save
                # @recipeingredient = @recipe.recipe_ingredients[i]
                # @recipeingredient.assign_attributes(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
                # @recipeingredient.save
                i += 1
            else
                @recipe.destroy
                flash[:form_errors] = @ingredient.errors.messages
                redirect_to "/index/#{session[:user_id]}"
                return
            end
        end

        i = 0
        while i < recipe_params[:steps][:descriptions].length
            @step = @recipe.steps[i]
            @step.assign_attributes(description: recipe_params[:steps][:descriptions][i])
            # @recipestep = @recipe.recipe_steps[i]
            # @recipestep.assign_attributes(recipe_id: @recipe.id, step_id: @step.id)
            # @recipestep.save
            i += 1
        end

        if recipe_params[:new_ingredients]
            i = 0
            while i < recipe_params[:new_ingredients][:names].length
                @ingredient = Ingredient.new(name: recipe_params[:new_ingredients][:names][i], category: recipe_params[:new_ingredients][:categories][i], quantity: recipe_params[:new_ingredients][:quantities][i], units: recipe_params[:new_ingredients][:units][i])
                if @ingredient.valid?
                    @ingredient.save
                    @recipeingredient = RecipeIngredient.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
                    @recipeingredient.save
                    i += 1
                    # redirect_to "/index/#{session[:user_id]}"

                else
                    @recipe.destroy
                    flash[:form_errors] = @ingredient.errors.messages
                    redirect_to "/index/#{session[:user_id]}"
                    return
                end
            end
        end

        if recipe_params[:new_steps]
            i = 0
            while i < recipe_params[:new_steps][:descriptions].length
                @step = Step.create(description: recipe_params[:new_steps][:descriptions][i])
                @recipestep = RecipeStep.new(recipe_id: @recipe.id, step_id: @step.id)
                @recipestep.save
                i += 1
            end
            # redirect_to "/index/#{session[:user_id]}"
            # return
        end
        redirect_to "/index/#{session[:user_id]}"
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        redirect_to "/index/#{session[:user_id]}"
    end

    def recipe_params
        params.permit(
              recipe: [
                :title,
                :category
              ],
              ingredients: [
                names: [],
                categories: [],
                quantities: [],
                units: []
              ],
              steps: [
                  descriptions: []
              ], 
            new_ingredients: [
                names: [],
                categories: [],
                quantities: [],
                units: []
              ],
              new_steps: [
                descriptions: []
            ]
            )
        
    end

end

