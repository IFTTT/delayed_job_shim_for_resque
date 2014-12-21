module DelayedJobShimForResque
  class MethodProxy
    def initialize(target, options)
      @target = target
      # Not yet implemented
      @options = options
    end

    # This is unfortunate, but it's how DelayedJob works.
    def method_missing(method, *args)
      # This is the Resque queue to which this job will be sent
      queue = @options[:to] || :default
      # Encode our Performable Method into something that can be stored in Resque
      payload = PerformableMethod.encode(@target, method, args)
      # Skip Resque.enqueue convenience method and create the job ourselves.
      # Point to the PerformableMethod class (which Resque will call perform on)
      ::Resque::Job.create(queue, PerformableMethod, payload)
    end
  end

  module MessageSending
    def delay(options = {})
      MethodProxy.new(self, options)
    end

    module ClassMethods
      # This is essentially a metafunction around alias_method_chain to dynamically generate alias methods
      # so it borrows heavily from alias_method_chain
      def handle_asynchronously(target, options = {})
        # Might as well keep the structure of code from alias_method_chain
        feature = :delay
        # Strip out punctuation on predicates or bang methods since
        # e.g. target?_without_feature is not a valid method name.
        aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ''), $1
        with_method, without_method = "#{aliased_target}_with_#{feature}#{punctuation}", "#{aliased_target}_without_#{feature}#{punctuation}"

        # Define a method for method_with_delay that will replace the original method
        # Note, however, that this does not call the original method in the chain
        # until we are in the background process
        define_method(with_method) do |*args|
          delay(options).send(without_method, *args)
        end
        alias_method_chain target, feature

        case
        when public_method_defined?(without_method)
          public target
        when protected_method_defined?(without_method)
          protected target
        when private_method_defined?(without_method)
          private target
        end
      end
    end
  end
end