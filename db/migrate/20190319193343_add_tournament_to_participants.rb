class AddTournamentToParticipants < ActiveRecord::Migration[5.2]
  def change
    change_table :participants do |t|
      t.references :tournament
    end
  end
end
