class Comment < ApplicationRecord
  validates :name, :body, presence: true

  belongs_to :chapter
end
