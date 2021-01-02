# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  actors      :string
#  awards      :string
#  country     :string
#  director    :string
#  genre       :string
#  imdb_rating :string
#  language    :string
#  metascore   :string
#  my_score    :string           not null
#  plot        :string
#  poster      :string
#  rated       :string
#  released_at :string
#  runtime     :string
#  title       :string           not null
#  viewed_at   :date             not null
#  writer      :string
#  year        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  imdb_id     :string           not null
#
class Movie < ApplicationRecord
  validates :title, :year, :my_score, :viewed_at, :imdb_id, presence: true
end
