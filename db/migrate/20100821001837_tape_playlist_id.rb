class TapePlaylistId < ActiveRecord::Migration
  def self.up
    add_column :tapes, :playlist_id, :string
  end

  def self.down
    remove_column :tapes, :playlist_id
  end
end
