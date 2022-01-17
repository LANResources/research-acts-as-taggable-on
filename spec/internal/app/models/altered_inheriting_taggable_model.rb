require_relative 'taggable_model'

class AlteredInheritingTaggableModel < TaggableModel
  research_acts_as_taggable_on :parts
end
