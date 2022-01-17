# frozen_string_literal: true

class AddTenantToTaggings < ActiveRecord::Migration[6.0]
  def self.up
    add_column ResearchActsAsTaggableOn.taggings_table, :tenant, :string, limit: 128
    add_index ResearchActsAsTaggableOn.taggings_table, :tenant unless index_exists? ResearchActsAsTaggableOn.taggings_table, :tenant
  end

  def self.down
    remove_index ResearchActsAsTaggableOn.taggings_table, :tenant
    remove_column ResearchActsAsTaggableOn.taggings_table, :tenant
  end
end
