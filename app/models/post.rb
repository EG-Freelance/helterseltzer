class Post < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  def add_image(image)
    img = Image.new
    img.image = image
    img.save
    self.images << img    

    http = Curl.post('https://api.imgur.com/3/upload', { image: Paperclip.io_adapters.for(img.image).read }) { |h| h.headers = { Authorization: 'Client-ID ' + ( Rails.env == "development" ? Rails.application.secrets.imgur_client_id : ENV['IMGUR_CLIENT_ID'] ) } }
    json = JSON.parse(http.body)
    image_url = json['data']['link']
    img.update(ext_url: image_url)

  end
end
