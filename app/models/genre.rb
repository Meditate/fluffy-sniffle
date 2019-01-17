# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Genre < ApplicationRecord
  has_many :movies

  def movies_count
    movies.count
  end

  def self.movies_count
    @movies_count ||=
      left_outer_joins(:movies)
        .select("genres.id, COUNT(movies.id) as count")
        .group("genres.id")
        .map { |genre| { id: genre.id, count: genre.count } }
  end
end
