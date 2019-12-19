class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :post
      # use imgur API to get pics
      t.string :url

      t.timestamps null: false
    end
  end
end
