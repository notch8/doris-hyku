# Generated via
#  `rails generate curation_concerns:work GenericWork`
module Hyrax
  class GenericWorkForm < Hyrax::Forms::WorkForm
    include Hyrax::FormTerms
    self.model_class = ::GenericWork
    include HydraEditor::Form::Permissions
    self.terms = [:title, :creator, :creator_role, :added_creator, :added_creator_role, :contributor, :description, :keyword, :license, :rights_statement, :publisher, :date_created, :date_certainty, :subject, :language, :identifier, :based_near, :related_url, :representative_id, :thumbnail_id, :rendering_ids, :files, :visibility_during_embargo, :embargo_release_date, :visibility_after_embargo, :visibility_during_lease, :lease_expiration_date, :visibility_after_lease, :visibility, :ordered_member_ids, :source, :in_works_ids, :member_of_collection_ids, :admin_set_id, :resource_type, :rendering_ids, :material_type, :form, :color, :dimensions]

    def primary_terms
      [:identifier, :title, :creator, :creator_role, :added_creator, :added_creator_role]
    end

    def secondary_terms
      [:date_created, :date_certainty, :keyword, :rights_statement, :license, :material_type, :form, :color, :dimensions]
      #, :contributor, :description, :publisher, :date_created, :subject, :language, :based_near, :related_url, :source, :resource_type]
    end

    def required_fields
      [:title, :identifier, :date_created]
    end
  end
end
