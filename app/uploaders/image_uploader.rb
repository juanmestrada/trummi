# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

 include CarrierWave::MiniMagick
  process resize_to_limit: [800, 800]

  version :thumb do
    process resize_to_fill: [150,150]
  end
  
  # Choose what kind of storage to use for this uploader:
  # if Rails.env.production?
  #   storage :aws
  # else
  #   storage :file
  # end
  storage :fog
  

  # def download_url(filename)
  #   url(response_content_disposition: %Q{attachment; filename="#{filename}"})
  # end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def content_type_denylist
    ['application/text', 'application/json']
  end

end
