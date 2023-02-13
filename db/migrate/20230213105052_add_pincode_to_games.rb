class AddPincodeToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :pincode, :string
  end
end
