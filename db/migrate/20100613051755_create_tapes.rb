class CreateTapes < ActiveRecord::Migration
  def self.up
    create_table :tapes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :tapes
  end
end
