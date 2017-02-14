class MealPlan < ApplicationRecord
    belongs_to :user
    has_many :meals, -> { order(:date) }, inverse_of: :meal_plan, dependent: :destroy

    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :user, presence: true

    accepts_nested_attributes_for :meals

    def build_meals
        available_recipe_ids = user.recipes.pluck(:id)

        (start_date..end_date).each do |date|
            available_recipe_ids = user.recipes.pluck(:id) if available_recipe_ids.empty?

            next_recipe_id = available_recipe_ids.delete_at(rand(available_recipe_ids.length))
            meals.build(date: date, recipe_id: next_recipe_id)
        end
    end

    def to_s
        "#{start_date} - #{end_date}"
    end
end