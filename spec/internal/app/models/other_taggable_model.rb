class OtherTaggableModel < ActiveRecord::Base
  research_acts_as_taggable_on :tags, :languages
  research_acts_as_taggable_on :needs, :offerings
end
