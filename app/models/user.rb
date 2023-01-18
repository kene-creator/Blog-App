class User < ApplicationRecord
    attr_accessor :name :photo :bio :post_counter

    has_many :comments
    has_many :posts
    has_many :likes
end
