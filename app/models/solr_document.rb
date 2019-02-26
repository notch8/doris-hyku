# frozen_string_literal: true

class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior

  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.
  use_extension(Hydra::ContentNegotiation)

  attribute :extent, Solr::Array, solr_name('extent')

  attribute :date_certainty, Solr::Array, solr_name('date_certainty')
  attribute :material_type, Solr::Array, solr_name('material_type')
  attribute :form, Solr::Array, solr_name('form')
  attribute :color, Solr::Array, solr_name('color')
  attribute :dimensions, Solr::Array, solr_name('dimensions')
  attribute :physical_description_note, Solr::Array, solr_name('physical_description_note')
  attribute :source_of_description_note, Solr::Array, solr_name('source_of_description_note')
  attribute :caption_note, Solr::Array, solr_name('caption_note')
  attribute :attribution_note, Solr::Array, solr_name('attribution_note')
  attribute :publication_distribution_production_note, Solr::Array, solr_name('publication_distribution_production_note')
  attribute :immediate_source_of_acquisition, Solr::Array, solr_name('immediate_source_of_acquisition')
  attribute :copies_and_original , Solr::Array, solr_name('copies_and_original')
  attribute :place, Solr::Array, solr_name('place')
  attribute :subject, Solr::Array, solr_name('subject')
  attribute :occupation, Solr::Array, solr_name('occupation')
  attribute :name, Solr::Array, solr_name('names')
  attribute :genre_form, Solr::Array, solr_name('genre_form')
  attribute :repository, Solr::Array, solr_name('repository')
  attribute :access_advisory, Solr::Array, solr_name('access_advisory')
  attribute :rights_advisory, Solr::Array, solr_name('rights_advisory')
  attribute :preferred_citation, Solr::Array, solr_name('preferred_citation')
  attribute :digitized, Solr::String, solr_name('digitized', Solrizer::Descriptor.new(:boolean, :stored, :indexed))

end
