require 'delayed_job_shim_for_resque/railtie' if defined?(Rails)

require 'delayed_job_shim_for_resque/performable_method'
require 'delayed_job_shim_for_resque/message_sending'

Object.send(:include, DelayedJobShimForResque::MessageSending)
Module.send(:include, DelayedJobShimForResque::MessageSending::ClassMethods)