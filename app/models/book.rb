class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower


  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

	def favorited_by?(user)
	    favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def self.search(search,word)
                if search  == "forward_match"
                        @book = Book.where("title LIKE?","#{word}%")
                elsif search == "backward_match"
                        @book = Book.where("title LIKE?","%#{word}")
                elsif search == "perfect_match"
                        @book = Book.where("title LIKE?","#{word}")
                elsif search == "partial_match"
                        @book = Book.where("title LIKE?","%#{word}%")
                else
                        @book = Book.all
                end
	end
end
