class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :media_id
      t.integer :media_type, :default => 0
      t.string :thumbnail
      t.string :title

      t.timestamps
    end
  end
end
