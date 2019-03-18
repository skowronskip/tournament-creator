class AddStateToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :state, :integer, default: 0
  end
end
