# Generated by hyrax:models:install
class FileSet < ActiveFedora::Base
  include ::CommonMetadata
  include ::Hyrax::FileSetBehavior

  before_destroy :remove_rendering_relationship
  after_update :clear_cache

  # Hyku has its own FileSetIndexer: app/indexers/file_set_indexer.rb
  # It overrides Hyrax to inject IIIF behavior.
  self.indexer = FileSetIndexer

  def rendering_ids
    to_param
  end

  # clean out RIIF cache when the file changes
  def clear_cache
   FileUtils.rm_f(Rails.root.join('tmp', 'network_files')) 
  end

  private

    # If any parent objects are pointing at this object as their
    # rendering, remove that pointer.
    def remove_rendering_relationship
      parent_objects = parents
      return if parent_objects.empty?
      parent_objects.each do |work|
        if work.rendering_ids.include(id)
          new_rendering_ids = work.rendering_ids.delete(id)
          work.update(rendering_ids: new_rendering_ids)
        end
      end
    end
end
