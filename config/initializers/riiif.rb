Riiif::Image.file_resolver = Riiif::HTTPFileResolver.new
Riiif::Image.info_service = lambda do |id, _file|
  # id will look like a path to a pcdm:file
  # (e.g. rv042t299%2Ffiles%2F6d71677a-4f80-42f1-ae58-ed1063fd79c7)
  # but we just want the id for the FileSet it's attached to.

  # Capture everything before the first slash
  fs_id = id.sub(/\A([^\/]*)\/.*/, '\1')
  resp = ActiveFedora::SolrService.get("id:#{fs_id}")
  doc = resp['response']['docs'].first
  raise "Unable to find solr document with id:#{fs_id}" unless doc
  { height: doc['height_is'], width: doc['width_is'] }
end

Riiif::Image.file_resolver.id_to_uri = lambda do |id|
  ActiveFedora::Base.id_to_uri(CGI.unescape(id)).tap do |url|
    Rails.logger.info "Riiif resolved #{id} to #{url}"
  end
end

Riiif::Image.authorization_service = Hyrax::IIIFAuthorizationService

Riiif.not_found_image = Rails.root.join('app', 'assets', 'images', 'us_404.svg')
Riiif.unauthorized_image = Rails.root.join('app', 'assets', 'images', 'us_404.svg')

Riiif::Engine.config.cache_duration_in_days = 365


Riiif::ImagemagickCommandFactory.class_eval do
  # def build
  #   [external_command, crop, size, rotation, colorspace, quality, watermark, sampling, metadata, output].join
  # end

  # def watermark
  #   [' -font Arial -pointsize 24',
  #    '-draw "gravity center',
  #    'fill black  text 0,12 \'Copyright\'',
  #    'fill white  text 1,11 \'Copyright\'"'
  #   ].join(' ')
  # end
  def command
    Rails.logger.debug "================ command"

    [external_command, crop, size, rotation, colorspace, quality, sampling, metadata, output, watermark].join
  end

  def build
    Rails.logger.debug "================ build"

    [external_command, crop, size, rotation, colorspace, quality, sampling, metadata, output, watermark].join
  end

  def watermark
    Rails.logger.debug "================ watermark"
    " | composite -watermark 80 -tile #{Rails.root.join('app/assets/images/watermark.png')}  - #{transformation.format}:-"
  end

end
