class Image < ActiveRecord::Base
  belongs_to :post
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


end
