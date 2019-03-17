class AddTeamsToMatch < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.references :home_team
      t.references :away_team
    end
  end
end
