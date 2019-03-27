## Pulled in from Hyrax to clear the RIIIF cache
class IngestJob < Hyrax::ApplicationJob
  queue_as Hyrax.config.ingest_queue_name

  after_perform do |job|
    # We want the lastmost Hash, if any.
    opts = job.arguments.reverse.detect { |x| x.is_a? Hash } || {}
    wrapper = job.arguments.first
    ContentNewVersionEventJob.perform_later(wrapper.file_set, wrapper.user) if opts[:notification]
    # Cache Clearing
    wrapper.file_set.files.each do |file|
      Rails.logger.debug("Removing File with id:#{file.id}")
      FileUtils.rm_rf(Rails.root.join('tmp', 'network_files', Digest::MD5.hexdigest(file.uri.to_s)))
    end
    Rails.cache.clear
  end

  # @param [JobIoWrapper] wrapper
  # @param [Boolean] notification send the user a notification, used in after_perform callback
  # @see 'config/initializers/hyrax_callbacks.rb'
  # rubocop:disable Lint/UnusedMethodArgument
  def perform(wrapper, notification: false)
    wrapper.ingest_file
  end
end
