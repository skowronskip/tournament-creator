class AddMatchNumberToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :match_no,:integer
  end
end
