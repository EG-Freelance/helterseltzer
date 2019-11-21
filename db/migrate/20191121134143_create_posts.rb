class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.date :date
      t.string :product
      t.text :review
      t.string :game
      t.text :summary

      t.timestamps null: false
    end
  end
end
