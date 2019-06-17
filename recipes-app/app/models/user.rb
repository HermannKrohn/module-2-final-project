class User < ApplicationRecord
    has_many :user_recipes, dependent: :destroy
    has_many :recipes, through: :user_recipes
    has_many :relationships, dependent: :destroy

    def following
        following_ids = Relationship.all.select do | relationship |
            relationship.follower_id == self.id
        end.map do | follower_relationships |
            follower_relationships.followed_id
        end

        following_objects = []
        following_ids.each do |following_id|
            following_objects << User.find(following_id)
        end
        following_objects
    end

    def followers
        follower_ids = Relationship.all.select do | relationship |
            relationship.followed_id == self.id
        end.map do | followed_relationships |
            followed_relationships.follower_id
        end

        follower_objects = []
        follower_ids.each do |follower_id|
            follower_objects << User.find(follower_id)
        end
        follower_objects
    end

end
