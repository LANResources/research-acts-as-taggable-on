if using_postgresql?
  class CachedModelWithArray < ActiveRecord::Base
    research_acts_as_taggable
  end
end
