class Page < ActiveRecord::Base
   audited

   attr_accessible :name
   attr_accessible :description
   attr_accessible :navigation_name
   attr_accessible :slug
   attr_accessible :title
   attr_accessible :content
   attr_accessible :published

   validates :name, :description, :navigation_name, :presence => true
   validates :title, :content, :presence => true

   after_create :slugify!

   scope :published, lambda { where(:published => true) }

   def to_param
      "#{self.id} #{self.title}".parameterize
   end

   private

   def slugify!
      self.slug = "#{self.name} #{self.id}".parameterize
      self.save()
   end
end
