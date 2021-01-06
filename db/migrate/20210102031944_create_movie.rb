class CreateMovie < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string  :title, null: false
      t.string  :year, null: false
      t.string  :rated
      t.date    :released
      t.string  :runtime
      t.string  :genre
      t.string  :director
      t.string  :writer
      t.string  :actors
      t.string  :plot
      t.string  :language
      t.string  :country
      t.string  :awards
      t.string  :poster
      t.float   :imdbrating, default: 0
      t.integer :metascore, default: 0
      t.string  :imdbid, null: false

      t.float   :my_score, null: false
      t.date    :viewed_at, null: false

      t.timestamps
    end
  end
end
