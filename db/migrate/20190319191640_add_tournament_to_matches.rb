class AddTournamentToMatches < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.references :tournament
    end
  end
end
