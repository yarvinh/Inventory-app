class CreateSneakers < ActiveRecord::Migration[6.0]
  def change
    create_table :sneakers do |t|
      t.string :size
      t.string :gender
      t.string :style
      t.integer :price
      t.integer :quantity
      t.string :color
      t.string :bar_code
      t.string :brand_id
    end
  end
end
