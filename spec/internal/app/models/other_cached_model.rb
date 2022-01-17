class OtherCachedModel < ActiveRecord::Base
  research_acts_as_taggable_on :languages, :statuses, :glasses
end
