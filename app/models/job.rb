class Job < ActiveRecord::Base

  serialize :params
  serialize :response

  STATE_NEW         = 100
  STATE_RUNNING     = 200
  STATE_PAUSED      = 300
  STATE_FINISHED    = 400
  STATE_ERROR       = 500

  class << self
    def param(name)
      instance_variable_set(:@__required_params, []) unless instance_variable_get(:@__required_params)
      instance_variable_get(:@__required_params) << name.to_sym

      define_method(name.to_sym) do
        eval("self.params ||= Hash.new")
        eval("self.params").fetch(name.to_sym)
      end

      define_method("#{name}=".to_sym) do |v|
        eval("self.params ||= Hash.new")
        eval("self.params").send(:store, name.to_sym, v)
      end
    end

    def queue
      instance_variable_get(:@__queue) || name.to_s.downcase.gsub("::", "_")
    end

    def queue_in(name)
      instance_variable_set(:@__queue, name)
    end
  end

  # ensure required parameters are supplied
  def validate_params!
    self.params ||= Hash.new
    self.class.instance_variable_get(:@__required_params).each do |e|
      raise ArgumentError, "Insufficient parameters set (#{e} not supplied)" if self.params[e].nil?
    end
  end

  # Meta information storage
  def meta_store_get(k)
    self.params[:meta_store] ||= {}
    self.params[:meta_store][k.to_sym]
  end

  def meta_store_set(k, v)
    self.params[:meta_store] ||= {}
    self.params[:meta_store][k.to_sym] = v
    self.save!
  end

  # Job Submission
  def submit!
    self.validate_params!
    self.state = STATE_NEW
    self.name = self.class.name
    self.save!

    begin
      Resque.enqueue(self.class, self.id)
    rescue => e
      raise e
    end
  end

  def state_name
    case self.state
    when STATE_NEW
      "New"
    when STATE_RUNNING
      "Running"
    when STATE_FINISHED
      "Finished"
    when STATE_ERROR
      "Error"
    when STATE_PAUSED
      "Paused"
    else
      "Unknown"
    end
  end

  # Workers should override this
  def perform
    raise RuntimeError, "Worker Implementations should override this"
  end

  # Resque Function
  def self.perform(job_id)
    job = self.find(job_id.to_i)
    job.state = STATE_RUNNING
    job.save!

    begin
      job.perform()
      job.state = STATE_FINISHED
    rescue => e
      job.state = STATE_ERROR
      job.error_message = e.message.to_s
      job.error_detail = e.backtrace.join("\n")
    ensure
      job.save!
    end
  end

end
