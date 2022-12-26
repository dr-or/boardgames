class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :address
      t.datetime :datetime

      t.timestamps
    end
  end
end
