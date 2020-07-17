require_relative 'helper'
require_relative 'entities/chapter_entity'

module API
  class Chapters < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :chapters do
      desc 'Returns list of active chapters' do
        success ChapterEntity
      end
      params do
        optional :all, type: Boolean, desc: 'Show all chapters (including archived)'
      end
      get do
        chapters = params[:all] ? ::Chapter.all : ::Chapter.active_chapters
        present chapters, \
          with: ChapterEntity
      end
    end

  end
end
