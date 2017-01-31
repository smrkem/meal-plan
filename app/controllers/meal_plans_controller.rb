class MealPlansController < ApplicationController
    before_action :require_login

    def new
        @meal_plan = current_user.meal_plans.build(
            start_date: params[:start_date] || Date.today,
            end_date: params[:end_date] || 6.days.from_now.to_date
        )

        @meal_plan.build_meals
    end
end