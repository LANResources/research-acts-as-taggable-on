# frozen_string_literal: true

class AddTaggingsCounterCacheToTags < ActiveRecord::Migration[6.0]
  def self.up
    add_column ResearchActsAsTaggableOn.tags_table, :taggings_count, :integer, default: 0

    ResearchActsAsTaggableOn::Tag.reset_column_information
    ResearchActsAsTaggableOn::Tag.find_each do |tag|
      ResearchActsAsTaggableOn::Tag.reset_counters(tag.id, ResearchActsAsTaggableOn.taggings_table)
    end
  end

  def self.down
    remove_column ResearchActsAsTaggableOn.tags_table, :taggings_count
  end
end
