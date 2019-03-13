class PageAccessPermission < ActiveRecord::Base
  audited

  attr_accessible :permission_type
  attr_accessible :user_id
  attr_accessible :page_id

  belongs_to :page
  belongs_to :user

  PERM_READWRITE  = "ReadWrite"
  PERM_READONLY   = "ReadOnly"
  
  PERM_ALL = [
    PERM_READWRITE, PERM_READONLY
  ]

  def self.can_manage?(user, page)
    return false if user.nil?
    return false if page.nil?
    
    ! PageAccessPermission.where('user_id = ? AND page_id = ? AND permission_type = ?',
        user.id, page.id, PERM_READWRITE).count.zero?
  end

end
