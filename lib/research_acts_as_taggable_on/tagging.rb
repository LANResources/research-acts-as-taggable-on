# frozen_string_literal: true

module ResearchActsAsTaggableOn
  class Tagging < ::ResearchRecord # :nodoc:
    self.table_name = ResearchActsAsTaggableOn.taggings_table

    DEFAULT_CONTEXT = 'tags'
    belongs_to :tag, class_name: '::ResearchActsAsTaggableOn::Tag', counter_cache: ResearchActsAsTaggableOn.tags_counter
    belongs_to :taggable, polymorphic: true

    belongs_to :tagger, polymorphic: true, optional: true

    scope :owned_by, ->(owner) { where(tagger: owner) }
    scope :not_owned, -> { where(tagger_id: nil, tagger_type: nil) }

    scope :by_contexts, ->(contexts) { where(context: (contexts || DEFAULT_CONTEXT)) }
    scope :by_context, ->(context = DEFAULT_CONTEXT) { by_contexts(context.to_s) }

    scope :by_tenant, ->(tenant) { where(tenant: tenant) }

    validates_presence_of :context
    validates_presence_of :tag_id

    validates_uniqueness_of :tag_id, scope: %i[taggable_type taggable_id context tagger_id tagger_type]

    after_destroy :remove_unused_tags

    private

    def remove_unused_tags
      if ResearchActsAsTaggableOn.remove_unused_tags
        if ResearchActsAsTaggableOn.tags_counter
          tag.destroy if tag.reload.taggings_count.zero?
        elsif tag.reload.taggings.none?
          tag.destroy
        end
      end
    end
  end
end
