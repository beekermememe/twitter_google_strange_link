class CreateWordSearches < ActiveRecord::Migration
  def self.up
    create_table :word_searches do |t|
      t.string :keyword
      t.text :results_yahoo
      t.text :results_twitter
      t.date_time :last_search
      t.integer :search_hitcount_per_ten_mins

      t.timestamps
    end
  end

  def self.down
    drop_table :word_searches
  end
end
