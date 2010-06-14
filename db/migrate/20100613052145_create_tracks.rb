class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.integer :tapester_id, :null => false
      t.integer :tape_id, :null => false
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
