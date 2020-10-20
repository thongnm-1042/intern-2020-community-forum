class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    Settings.store.avatar_dir
  end

  process resize_to_fit: Settings.store.size

  version :thumb do
    process resize_to_fill: Settings.store.size
  end

  def extension_whitelist
    Settings.config_image.image
  end
end
