class Movie < ApplicationRecord
  has_many :bookmarks
  validates :name, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :poster_url, presence: true
  validates :rating, presence: true, numericality: { only_numeric: true, greater_than_or_equal_to: 0 }

  before_destroy :check_bookmarks

  private

  def check_bookmarks
    return unless Bookmark.where(movie_id: id).count.zero?

    bookmarks_w_movie = Bookmark.where(movie_id: id).count
    ending = 's' if bookmarks_w_movie > 1
    ending ||= ''

    errors.add(
      :base,
      :undestroyable,
      message: "Movie is referenced in #{bookmarks_w_movie} bookmark#{ending}"
    )
    throw :abort
  end
end
