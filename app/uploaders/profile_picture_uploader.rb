class ProfilePictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Pohrana datoteka lokalno
  storage :file

  # Verzije slike
  version :thumb do
    process resize_to_fit: [200, nil]
  end

  version :large do
    process resize_to_fit: [600, nil]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
