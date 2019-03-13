# Generic Background Job for Models
module Worker
  
  module BackgroundJobHelper
    def enque_background!
      worker = ::Worker::BackgroundJobWorker.new
      worker.model_name = self.class.to_s
      worker.model_id = self.id

      worker.submit!
    end
  end

  class BackgroundJobWorker < ::Job
    queue_in 'background-jobs'

    param :model_name
    param :model_id

    def info
      "N/A"
    end

    def perform
      model = ::Object.const_get(self.model_name.to_s).find(self.model_id.to_i)
      model.do_background()
    end

  end
end