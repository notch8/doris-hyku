Hydra::Derivatives::Processors::Image.class_eval do

  protected
  def create_image
    xfrm = selected_layers(load_image_transformer)
    yield(xfrm) if block_given?
    xfrm.format(directives.fetch(:format))
    xfrm.quality(quality.to_s) if quality
    logo = MiniMagick::Image.open(Rails.root.join('app/assets/images/watermark.png'))
    if xfrm.width < 650
      logo.resize("#{xfrm.width/2}")
    end
    xfrm = xfrm.composite(logo) do |c|
      c.watermark '10'
      c.tile
    end
    write_image(xfrm)
  end
end
