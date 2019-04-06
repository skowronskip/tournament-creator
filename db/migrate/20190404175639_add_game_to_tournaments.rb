class AddGameToTournaments < ActiveRecord::Migration[5.2]
  def change
    change_table :tournaments do |t|
      t.references :game
    end
  end
end
