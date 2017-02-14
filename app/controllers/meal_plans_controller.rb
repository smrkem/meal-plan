class MealPlansController < ApplicationController
    before_action :require_login

    def index
        @current_meal_plan = current_user.meal_plans.where(
            "start_date <= ? and end_date >= ?", Date.today, Date.today).first
        @meal_plans = current_user.meal_plans.order("start_date DESC")
    end

    def show
        @meal_plan = current_user.meal_plans.find(params[:id])
    end

    def new
        start_date = params[:meal_plan].present? ? meal_plan_params[:start_date] : Date.today
        end_date = params[:meal_plan].present? ? meal_plan_params[:end_date] : 6.days.from_now.to_date
        @meal_plan = current_user.meal_plans.build(
            start_date: start_date,
            end_date: end_date
        )

        @meal_plan.build_meals
    end

    def create
        @meal_plan = current_user.meal_plans.build(meal_plan_params)

        if @meal_plan.save
            redirect_to meal_plan_path(@meal_plan), notice: "Meal Plan created!"
        else
            @errors = @meal_plan.errors.full_messages
            render :new
        end
    end

    def edit
        @meal_plan = current_user.meal_plans.find(params[:id])
    end

    def update
        @meal_plan = current_user.meal_plans.find(params[:id])

        if @meal_plan.update_attributes(meal_plan_params)
            redirect_to meal_plan_path(@meal_plan), notice: "Meal Plan Updated!"
        else
            @errors = @meal_plan.errors.full_messages
            render edit
        end
    end

    def destroy
        @meal_plan = current_user.meal_plans.find(params[:id])
        @meal_plan.destroy
        redirect_to meal_plans_path, notice: "Meal Plan Deleted!"
    end

    private

    def meal_plan_params
        params.require(:meal_plan).permit(
            :start_date,
            :end_date,
            meals_attributes: [:id, :date, :recipe_id]
        )
    end
end