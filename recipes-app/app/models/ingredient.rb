class Ingredient < ApplicationRecord

    has_many :recipe_ingredients, dependent: :destroy
    has_many :recipes, through: :recipe_ingredients

    validates :quantity, numericality: true
    validates :category, presence: true
    validates :name, presence: true

end
