module DelayedJobShimForResque
  class Railtie < Rails::Railtie
    initializer "delayed_job_shim_for_resque.connection_pooling" do
      config.after_initialize do
        Resque.before_fork do
          defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
        end

        Resque.after_fork do
          defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
        end
      end
    end
  end
end