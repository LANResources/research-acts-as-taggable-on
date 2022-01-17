class NonStandardIdTaggableModel < ActiveRecord::Base
  self.primary_key = :an_id
  research_acts_as_taggable
  research_acts_as_taggable_on :languages
  research_acts_as_taggable_on :skills
  research_acts_as_taggable_on :needs, :offerings
  has_many :untaggable_models
end
