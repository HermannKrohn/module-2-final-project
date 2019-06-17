class Step < ApplicationRecord

    has_many :recipe_steps, dependent: :destroy
    has_many :recipes, through: :recipe_steps

end
