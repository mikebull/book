class Chapter < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates :body, presence: true

  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  def self.add_slugs
    update(slug: to_slug(name))
  end
  
  def self.to_slug(string)
    string.parameterize.truncate(80, omission: '')
  end

  def to_param
    slug
  end
end