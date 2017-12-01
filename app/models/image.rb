class Image < ApplicationRecord
  belongs_to :book
  mount_uploader :image_url, ImageUploader
end
