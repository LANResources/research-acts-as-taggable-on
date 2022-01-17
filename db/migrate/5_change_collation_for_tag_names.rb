# frozen_string_literal: true

# This migration is added to circumvent issue #623 and have special characters
# work properly

class ChangeCollationForTagNames < ActiveRecord::Migration[6.0]
  def up
    if ResearchActsAsTaggableOn::Utils.using_mysql?
      execute("ALTER TABLE #{ResearchActsAsTaggableOn.tags_table} MODIFY name varchar(255) CHARACTER SET utf8 COLLATE utf8_bin;")
    end
  end
end
