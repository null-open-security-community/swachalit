class UserAchievement < ActiveRecord::Base
  attr_accessible :achievement_type, :reference, :info

  validates :achievement_type, :reference, :info, :presence => true
  validates :reference, :uniqueness => [:user_id]

  A_TYPE_VULNERABILITY_DISCOVERY    = "Bug Discovery"
  A_TYPE_BUG_BOUNTY                 = "Bug Bounty"
  A_TYPE_OSS_PROJECT                = "Open Source"
  A_TYPE_COMMUNITY_SUPPORT          = "Community Support"

  A_TYPE_ALL = UserAchievement.constants.map do |e|
    if (e.to_s =~ /^A_TYPE/) and (e.to_s != "A_TYPE_ALL")
      UserAchievement.const_get(e)
    end
  end.compact()

  A_SOURCE_SELF = "Self"
  A_SOURCE_NULL = "null"

  A_SOURCE_ALL = [
    A_SOURCE_SELF, A_SOURCE_NULL
  ]

end
