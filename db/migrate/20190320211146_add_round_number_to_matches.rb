class AddRoundNumberToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :round_no, :integer
  end
end
