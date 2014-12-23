module DelayedJobShimForResque
  class PerformableMethod
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