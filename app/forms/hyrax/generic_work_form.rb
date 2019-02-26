# Generated via
#  `rails generate curation_concerns:work GenericWork`
module Hyrax
  class GenericWorkForm < Hyrax::Forms::WorkForm
    include Hyrax::FormTerms
    self.model_class = ::GenericWork
    include HydraEditor::Form::Permissions
    self.terms = [:title, :creator, :creator_role, :added_creator, :added_creator_role, :contributor, :description, :keyword, :license, :rights_statement, :publisher, :date_created, :date_certainty, :subject, :language, :identifier, :based_near, :related_url, :representative_id, :thumbnail_id, :rendering_ids, :files, :visibility_during_embargo, :embargo_release_date, :visibility_after_embargo, :visibility_during_lease, :lease_expiration_date, :visibility_after_lease, :visibility, :ordered_member_ids, :source, :material_type, :form, :color, :dimensions, :physical_description_note, :source_of_description_note, :caption_note, :attribution_note, :publication_distribution_production_note, :immediate_source_of_acquisition, :copies_and_original, :place, :occupation, :name, :genre_form, :repository, :access_advisory, :rights_advisory, :preferred_citation, :box, :shelf, :copy_negative, :digitized, :extent, :resource_type, :in_works_ids, :member_of_collection_ids, :admin_set_id]

    self.required_fields = [:title, :identifier, :date_created, :digitized]

    def primary_terms
      [:identifier, :title, :digitized, :date_created, :date_certainty]
    end

    def secondary_terms
      [ :creator, :creator_role, :added_creator, :added_creator_role, :keyword, :rights_statement, :license, :material_type, :extent, :form, :color, :dimensions, :physical_description_note, :source_of_description_note, :caption_note, :attribution_note, :publication_distribution_production_note, :immediate_source_of_acquisition, :copies_and_original, :place, :subject, :occupation, :name, :genre_form, :repository, :access_advisory, :rights_advisory, :preferred_citation, :box, :shelf, :copy_negative]
      #, :contributor, :description, :publisher, :subject, :language, :based_near, :related_url, :source, :resource_type]
    end

  end
end
