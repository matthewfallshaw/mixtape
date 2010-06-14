class TapesterAuth < ActiveRecord::Migration
  def self.up
    add_column :tapesters, :hashed_password, :string
    add_column :tapesters, :password_salt, :string, :length => 20
    add_column :tapesters, :email, :string
  end

  def self.down
    remove_column :tapesters, :email
    remove_column :tapesters, :password_salt
    remove_column :tapesters, :hashed_password
  end
end
