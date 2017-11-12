class CreateMechanisms < ActiveRecord::Migration[5.0]
  def change
    create_table :mechanisms do |t|
      t.string :name
      t.integer :rating
      t.string :image
      t.integer :price
      t.references :Region, foreign_key: true

      t.timestamps
    end
  end
end
