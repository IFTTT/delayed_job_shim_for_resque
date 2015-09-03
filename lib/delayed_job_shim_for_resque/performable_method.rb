module DelayedJobShimForResque
  class PerformableMethod
    extend Resque::Plugins::ExponentialBackoff

    @backoff_strategy = [10.seconds, 1.minute, 10.minutes, 1.hour, 3.hours, 6.hours, 12.hours, 1.day]
    @expire_retry_key_after = @backoff_strategy.last * 2 # Bumped after every retry, set to 2x the longest delay between retries

    def self.perform(payload)
      klass = payload["klass"].constantize
      if payload.include? "id"
        target = klass.find(payload["id"])
      else
        target = klass
      end
      target.send payload["method"], *payload["args"]
    end

    def self.prepare(target, method, args)
      klass = (target.class.name == 'Class') ? target.name : target.class.name
      hash = {:klass => klass, :method => method, :args => args}
      hash[:id] = target.id if target.class.name != 'Class'
      hash
    end
  end
end
