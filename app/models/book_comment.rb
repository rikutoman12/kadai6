class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
   belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :comment, presence: true
end
