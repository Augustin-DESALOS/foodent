class AddNicknameToTable < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :nickname, :string
  end
end
