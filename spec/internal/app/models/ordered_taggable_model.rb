class OrderedTaggableModel < ActiveRecord::Base
  research_acts_as_ordered_taggable
  research_acts_as_ordered_taggable_on :colours
end
