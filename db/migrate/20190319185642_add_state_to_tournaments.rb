class AddStateToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :state, :integer, default: 0
  end
end
