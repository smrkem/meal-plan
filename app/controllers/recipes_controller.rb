class RecipesController < ApplicationController
    before_action :require_login

    def index
        @recipes = current_user.recipes
    end

    def show
        @recipe = current_user.recipes.find(params[:id])
    end

    def new
        @recipe = current_user.recipes.build
    end

    def create
        @recipe = current_user.recipes.build(recipe_params)

        if @recipe.save
            redirect_to recipe_path(@recipe), notice: "Recipe Created!"
        else
            @errors = @recipe.errors.full_messages
            render :new
        end
    end

    def destroy
        recipe = current_user.recipes.find(params[:id])
        recipe.destroy
        redirect_to recipes_path, notice: "Deleted recipe: ${recipe.name}"
    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :description)
    end
end