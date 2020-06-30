class CreateProductsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :products_tags do |t|
      t.belongs_to :product
      t.belongs_to :tag

      t.timestamps
    end
  end
end
