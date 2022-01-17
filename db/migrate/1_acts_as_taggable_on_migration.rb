# frozen_string_literal: true

class ResearchActsAsTaggableOnMigration < ActiveRecord::Migration[6.0]
  def self.up
    create_table ResearchActsAsTaggableOn.tags_table do |t|
      t.string :name
      t.timestamps
    end

    create_table ResearchActsAsTaggableOn.taggings_table do |t|
      t.references :tag, foreign_key: { to_table: ResearchActsAsTaggableOn.tags_table }

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true

      # Limit is created to prevent MySQL error on index
      # length for MyISAM table type: http://bit.ly/vgW2Ql
      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index ResearchActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type context],
              name: 'taggings_taggable_context_idx'
  end

  def self.down
    drop_table ResearchActsAsTaggableOn.taggings_table
    drop_table ResearchActsAsTaggableOn.tags_table
  end
end
