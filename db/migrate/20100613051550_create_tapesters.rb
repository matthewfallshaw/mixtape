class CreateTapesters < ActiveRecord::Migration
  def self.up
    create_table :tapesters do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :tapesters
  end
end
