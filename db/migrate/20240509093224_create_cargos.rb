class CreateCargos < ActiveRecord::Migration[7.1]
  def change
    create_table :cargos do |t|
      t.references :user, null: false, foreign_key: true
      t.float :weight
      t.float :length
      t.float :width
      t.string :height
      t.text :point_of_departure
      t.text :destination
      t.float :distance
      t.float :price

      t.timestamps
    end
  end
end
