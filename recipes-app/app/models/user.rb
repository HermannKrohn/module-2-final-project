class User < ApplicationRecord
    has_many :user_recipes, dependent: :destroy
    has_many :recipes, through: :user_recipes
    has_many :relationships, dependent: :destroy

    validate :registration, on: :create_account

    def registration
        if self.username.length < 8
            self.errors.add(:username_length, "Username must be at least 8 characters long")
        end

        if !has_digits?(self.username)
            self.errors.add(:username_digits, "Username must have at least 1 number")
        end

        if self.first_name.length < 1
            self.errors.add(:first_name_length, "Please enter a first name")
        end

        if self.last_name.length < 1
            self.errors.add(:last_name_length, "Please enter a last name")
        end

        if has_digits?(self.first_name)
            self.errors.add(:first_name_digits, "First name cannot have digits")
        end

        if has_digits?(self.last_name)
            self.errors.add(:last_name_digits, "Last name cannot have digits")
        end

        if self.age == nil
            self.errors.add(:age, "Please enter an age")
        end
        
        if self.age != nil 
            if self.age < 14
                self.errors.add(:age, "Looks like you are too young. Come back when you are 14!")
            end
        end     

        if self.password_hash.length < 8
            self.errors.add(:password_length, "Password must be at least 8 characters long")
        end

        if !password_has_digits?(self.password_hash)
            self.errors.add(:password_digits, "Password must have at least 2 digits")
        end
    end

    def has_digits?(str)
        str.count("0-9") > 0
    end

    def password_has_digits?(str)
        str.count("0-9") > 1
    end

    def hash_password(value)
        BCrypt::Password.create(value)
    end

    def authenticate(value)
        password = BCrypt::Password.new(self.password_hash)
        password == value
    end

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
