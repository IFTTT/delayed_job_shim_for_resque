module DelayedJobShimForResque
  class PerformableMethod
    def self.perform(payload)
      target = payload["klass"].constantize.find(payload["id"])
      target.send payload["method"], *payload["args"]
    end

    def self.encode(target, method, args)
      {:klass => target.class.name, :id => target.id, :method => method, :args => args}
    end
  end
end