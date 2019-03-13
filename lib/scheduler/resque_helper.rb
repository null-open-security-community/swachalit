module Scheduler
  module ResqueSchedulerHelper

    def self.included(base)
      base.send(:include, ResqueSchedulerInstanceMethods)
      base.extend(ResqueSchedulerClassMethods)
    end

    module ResqueSchedulerClassMethods
      # 
      # Generic callback handler for trigger scheduled tasks.
      # args = { :instance_id => N, :method_name => S }
      def perform(args)
        args = args.symbolize_keys!
        instance = self.find(args[:instance_id].to_i)
        instance.send(args[:method_name].to_s) if (!instance.nil?) and 
                                                  (instance.respond_to?(args[:method_name]))
      end
    end

    module ResqueSchedulerInstanceMethods
      def add_scheduled_task(trigger_time, cb_method_name)
        ::Resque.enqueue_at(trigger_time, self.class, 
          :instance_id => self.id, :method_name => cb_method_name.to_sym)
      end

      def remove_scheduled_task(cb_method_name)
        Resque.remove_delayed_selection { |args|
          begin
            (args[0]['method_name'].to_s == cb_method_name) and 
              (args[0]['instance_id'].to_i == self.id)
          rescue
            false
          end
        }
      end

      def remove_scheduled_tasks()
        Resque.remove_delayed_selection { |args| 
          begin
            (args[0]['instance_id'].to_i == self.id)
          rescue
            false
          end
        }
      end
    end
  end
end