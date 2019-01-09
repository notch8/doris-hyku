module CommonMetadata
  extend ActiveSupport::Concern

  included do
    property :creator_role, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#creator_roles")
    property :added_creator, predicate: ::RDF::Vocab::DC11.creator
    property :added_creator_role, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#creator_roles")
    property :date_certainty, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#date_certainty")
    property :material_type, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#material_type")
    property :form, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#form")
    property :color, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#color")
    property :dimensions, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#dimensions")
    property :physical_description_note, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#physical_description_note")
    property :source_of_description_note, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#source_of_description_note")
    property :caption_note, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#caption_note")
    property :attribution_note, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#attribution_note")
    property :publication_distribution_production_note, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#publication_distribution_production_note")
    property :immediate_source_of_acquisition, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#immediate_source_of_acquisition")
    property :copies_and_original, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/generic_work#copies_and_original")
    property :place, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/place")
    property :subject, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/subject")
    property :occupation, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/occupation")
    property :name, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/name")
    property :genre_form, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/genre_form")
    property :repository, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/repository")
    property :access_advisory, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/access_advisory")
    property :rights_advisory, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/rights_advisory")
    property :preferred_citation, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/preferred_citation")
    property :box, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/box")
    property :shelf, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/shelf")
    property :copy_negative, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/copy_negative")
    property :digitized, predicate: ::RDF::URI("http://#{Settings.multitenancy.admin_host}/digitzed")
  end
end
