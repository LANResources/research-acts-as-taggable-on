# frozen_string_literal: true

module ResearchActsAsTaggableOn
  module Taggable
    module TaggedWithQuery
      class QueryBase
        def initialize(taggable_model, tag_model, tagging_model, tag_list, options)
          @taggable_model = taggable_model
          @tag_model      = tag_model
          @tagging_model  = tagging_model
          @tag_list       = tag_list
          @options        = options
        end

        private

        attr_reader :taggable_model, :tag_model, :tagging_model, :tag_list, :options

        def taggable_arel_table
          @taggable_arel_table ||= taggable_model.arel_table
        end

        def tag_arel_table
          @tag_arel_table ||= tag_model.arel_table
        end

        def tagging_arel_table
          @tagging_arel_table ||= tagging_model.arel_table
        end

        def tag_match_type(tag)
          matches_attribute = tag_arel_table[:name]
          matches_attribute = matches_attribute.lower unless ResearchActsAsTaggableOn.strict_case_match

          if options[:wild].present?
            matches_attribute.matches("%#{escaped_tag(tag)}%", '!', ResearchActsAsTaggableOn.strict_case_match)
          else
            matches_attribute.matches(escaped_tag(tag), '!', ResearchActsAsTaggableOn.strict_case_match)
          end
        end

        def tags_match_type
          matches_attribute = tag_arel_table[:name]
          matches_attribute = matches_attribute.lower unless ResearchActsAsTaggableOn.strict_case_match

          if options[:wild].present?
            matches_attribute.matches_any(tag_list.map do |tag|
                                            "%#{escaped_tag(tag)}%"
                                          end, '!', ResearchActsAsTaggableOn.strict_case_match)
          else
            matches_attribute.matches_any(tag_list.map do |tag|
                                            escaped_tag(tag).to_s
                                          end, '!', ResearchActsAsTaggableOn.strict_case_match)
          end
        end

        def escaped_tag(tag)
          tag = tag.downcase unless ResearchActsAsTaggableOn.strict_case_match
          ResearchActsAsTaggableOn::Utils.escape_like(tag)
        end

        def adjust_taggings_alias(taggings_alias)
          taggings_alias = "taggings_alias_#{Digest::SHA1.hexdigest(taggings_alias)}" if taggings_alias.size > 75
          taggings_alias
        end
      end
    end
  end
end
