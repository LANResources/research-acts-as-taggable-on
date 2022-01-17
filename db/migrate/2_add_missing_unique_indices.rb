# frozen_string_literal: true

class AddMissingUniqueIndices < ActiveRecord::Migration[6.0]
  def self.up
    add_index ResearchActsAsTaggableOn.tags_table, :name, unique: true

    remove_index ResearchActsAsTaggableOn.taggings_table, :tag_id if index_exists?(ResearchActsAsTaggableOn.taggings_table, :tag_id)
    remove_index ResearchActsAsTaggableOn.taggings_table, name: 'taggings_taggable_context_idx'
    add_index ResearchActsAsTaggableOn.taggings_table,
              %i[tag_id taggable_id taggable_type context tagger_id tagger_type],
              unique: true, name: 'taggings_idx'
  end

  def self.down
    remove_index ResearchActsAsTaggableOn.tags_table, :name

    remove_index ResearchActsAsTaggableOn.taggings_table, name: 'taggings_idx'

    add_index ResearchActsAsTaggableOn.taggings_table, :tag_id unless index_exists?(ResearchActsAsTaggableOn.taggings_table, :tag_id)
    add_index ResearchActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type context],
              name: 'taggings_taggable_context_idx'
  end
end
