class MovieForm < ApplicationForm
  FORBIDDEN_ATTRIBUTES = %w[
    id
    updated_at
    created_at
  ].freeze
  ATTRIBUTES = (Movie.attribute_names - FORBIDDEN_ATTRIBUTES).freeze

  attr_accessor(*ATTRIBUTES)

  def initialize(args = {})
    super(args)
    @models = [movie]
  end

  def movie
    @movie ||= build_movie
  end

  private

  def build_movie
    Movie.new(
      title: title,
      year: year,
      rated: rated,
      released: released,
      runtime: runtime,
      genre: genre,
      director: director,
      writer: writer,
      actors: actors,
      plot: plot,
      language: language,
      country: country,
      awards: awards,
      poster: poster,
      metascore: metascore,
      imdbid: imdbid,
      my_score: my_score,
      viewed_at: viewed_at
    )
  end
end
