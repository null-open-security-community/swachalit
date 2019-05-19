class Venue < ActiveRecord::Base
  audited
  
  attr_accessible :name, :description, :address, :map_url, :map_embedd_code
  attr_accessible :contact_name, :contact_email, :contact_mobile, :contact_notes
  attr_accessible :chapter_id

  validates :name, :presence => true
  validates :chapter_id, :presence => true
  validates :address, :presence => true
  validates :contact_name, :presence => true

  belongs_to :chapter
  has_many :events, :dependent => :restrict_with_error
end
