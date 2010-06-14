class TapesterAuth < ActiveRecord::Migration
  def self.up
    add_column :tapesters, :crypted_password, :string
    add_column :tapesters, :password_salt, :string, :length => 20
    add_column :tapesters, :persistence_token, :string
    add_column :tapesters, :email, :string
    add_column :tapesters, :current_login_at, :datetime
    add_column :tapesters, :last_login_at, :datetime
    add_column :tapesters, :current_login_ip, :string
    add_column :tapesters, :last_login_ip, :string
  end

  def self.down
    remove_column :tapesters, :last_login_ip
    remove_column :tapesters, :current_login_ip
    remove_column :tapesters, :last_login_at
    remove_column :tapesters, :current_login_at
    remove_column :tapesters, :email
    remove_column :tapesters, :persistence_token
    remove_column :tapesters, :password_salt
    remove_column :tapesters, :crypted_password
  end
end
