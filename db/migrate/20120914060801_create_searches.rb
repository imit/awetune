class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query,:null => false
      t.datetime :last_crawled_at

      t.timestamps
    end
  end
end
