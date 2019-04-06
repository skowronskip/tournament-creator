class AddUserToTournaments < ActiveRecord::Migration[5.2]
  def change
    change_table :tournaments do |t|
      t.references :user
    end
  end
end
