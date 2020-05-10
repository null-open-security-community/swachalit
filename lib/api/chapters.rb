require_relative 'helper'

module API
  class Chapters < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :chapters do
      desc 'Returns list of active chapters'
      get do
        ::Chapter.active_chapters
      end
    end

  end
end
