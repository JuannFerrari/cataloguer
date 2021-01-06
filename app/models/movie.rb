# == Schema Information
#
# Table name: movies
#
#  id         :bigint           not null, primary key
#  actors     :string
#  awards     :string
#  country    :string
#  director   :string
#  genre      :string
#  imdbid     :string           not null
#  imdbrating :float            default(0.0)
#  language   :string
#  metascore  :integer          default(0)
#  my_score   :float            not null
#  plot       :string
#  poster     :string
#  rated      :string
#  released   :date
#  runtime    :string
#  title      :string           not null
#  viewed_at  :date             not null
#  writer     :string
#  year       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Movie < ApplicationRecord
  validates :title, :year, :my_score, :viewed_at, :imdbid, presence: true
end
