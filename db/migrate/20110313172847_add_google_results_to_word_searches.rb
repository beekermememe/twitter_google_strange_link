class AddGoogleResultsToWordSearches < ActiveRecord::Migration
  def self.up
    add_column :word_searches, :google_results, :text
  end

  def self.down
    remove_column :word_searches, :google_results
  end
end
