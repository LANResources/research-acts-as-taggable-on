if using_postgresql?
  class CachedModelWithArray < ActiveRecord::Base
    research_acts_as_taggable
  end
  if postgresql_support_json?
    class TaggableModelWithJson < ActiveRecord::Base
      research_acts_as_taggable
      research_acts_as_taggable_on :skills
    end
  end
end
