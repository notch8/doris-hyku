class GenericWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::CommonMetadata
  include HasRendering
  validates :title, presence: { message: 'Your work must have a title.' }
  property :extent, predicate: ::RDF::Vocab::DC.extent, multiple: true do |index|
    index.as :stored_searchable
  end

  include ::Hyrax::BasicMetadata

  validates :title, presence: { message: 'Your work must have a title.' }

  self.indexer = WorkIndexer
  self.human_readable_type = 'Work'
end
