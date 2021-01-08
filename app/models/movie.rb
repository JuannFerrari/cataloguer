# == Schema Information
#
# Table name: movies
#
#  id           :bigint           not null, primary key
#  actors       :string
#  awards       :string
#  country      :string
#  director     :string
#  genre        :string
#  imdbid       :string           not null
#  imdbrating   :float            default(0.0)
#  language     :string
#  metascore    :integer          default(0)
#  month_viewed :string           not null
#  my_score     :float            not null
#  plot         :string
#  poster       :string
#  rated        :string
#  released     :date
#  runtime      :string
#  title        :string           not null
#  writer       :string
#  year         :string           not null
#  year_viewed  :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Movie < ApplicationRecord
  validates :title, :year, :my_score, :year_viewed,
            :month_viewed, :imdbid, presence: true
end
