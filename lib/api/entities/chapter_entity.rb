module API
  class ChapterEntity < Grape::Entity
    expose :id, documentation: { type: Integer, desc: 'Chapter ID' }
    expose :name, documentation: { type: String, desc: 'Chapter Name' }
    expose :created_at
    expose :updated_at
  end
end
