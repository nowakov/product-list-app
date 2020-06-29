class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string  :name, limit: 80, null: false, index: { unique: true }
      t.text    :description
      t.decimal :price, precision: 9, scale: 2, null: false

      t.timestamps
    end
  end
end
