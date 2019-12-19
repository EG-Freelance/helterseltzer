class AddUrlToImage < ActiveRecord::Migration
  def change
    add_column :images, :ext_url, :string
  end
end
