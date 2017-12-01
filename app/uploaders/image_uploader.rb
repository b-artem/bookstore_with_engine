class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "bookstore/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  process resize_to_fit: [600, 800]

  version :little do
    process resize_to_fit: [200, 200]
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def extension_whitelist
    %w(jpg gif png)
  end
end
