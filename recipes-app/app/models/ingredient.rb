class Ingredient < ApplicationRecord

    has_many :recipe_ingredients, dependent: :destroy
    has_many :recipes, through: :recipe_ingredients

    validates :quantity, numericality: { greater_than_or_equal_to: 0 }

    validates :category, presence: true
    validates :name, presence: true
    validates :units, presence: true


end
