class RecipeStep < ApplicationRecord
    belongs_to :step
    belongs_to :recipe
end
