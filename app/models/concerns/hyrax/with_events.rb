module Hyrax
  module WithEvents
    def stream
      ## New code, set redis instance for writters
      Nest.new(event_class, Hyrax::RedisEventStore.instance)[to_param]
    end

    def event_class
      self.class.name
    end

    def events(size = -1)
      event_stream.fetch(size)
    end

    def log_event(event_id)
      event_stream.push(event_id)
    end

    private

    def event_store
      RedisEventStore
    end

    def event_stream
      event_store.for(stream[:event])
    end
  end
end
