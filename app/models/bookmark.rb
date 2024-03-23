class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  # validates :movie_id, presence: true
  # validates :list_id, presence: true
  validates_uniqueness_of :movie_id, scope: :list_id
  validates :comment, length: { minimum: 6 }
end
