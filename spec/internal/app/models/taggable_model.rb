class TaggableModel < ActiveRecord::Base
  research_acts_as_taggable
  research_acts_as_taggable_on :languages
  research_acts_as_taggable_on :skills
  research_acts_as_taggable_on :needs, :offerings
  research_acts_as_taggable_tenant :tenant_id

  has_many :untaggable_models

  attr_reader :tag_list_submethod_called

  def tag_list=(v)
    @tag_list_submethod_called = true
    super
  end
end
