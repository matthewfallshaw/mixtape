class TapesterAuth < ActiveRecord::Migration
  def self.up
    change_table(:tapesters) do |t|
      t.database_authenticatable :null => false
      t.rememberable
      t.trackable

      # t.confirmable
      # t.recoverable
      # t.lockable :lock_strategy => :none, :unlock_strategy => :both
      # t.token_authenticatable
    end

    add_index :tapesters, :email,                :unique => true
    # add_index :tapesters, :reset_password_token, :unique => true
    # add_index :tapesters, :confirmation_token,   :unique => true
    # add_index :tapesters, :unlock_token,         :unique => true
  end

  def self.down
    change_table(:tapesters) do |t|
      t.remove "email"
      t.remove "encrypted_password"
      t.remove "password_salt"
      t.remove "remember_token"
      t.remove "remember_created_at"
      t.remove "sign_in_count"
      t.remove "current_sign_in_at"
      t.remove "last_sign_in_at"
      t.remove "current_sign_in_ip"
      t.remove "last_sign_in_ip"
    end
  end
end
