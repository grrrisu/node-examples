module Queue
  module Event

    class Action

      attr_reader :player_id, :object_id, :method, :args

      def initialize player_id, object_id: nil, method: nil, args: []
        @player_id = player_id
        @object_id = object_id
        @method    = method
        @args      = args
      end

      def fire
        if object_id && method
          raise "TODO find object and send method with args"
        else
          raise ArgumentError, "object_id and method are required"
        end
      end

      def broadcast player_ids, message
        broadcaster = Celluloid::Actor[:broadcaster]
        broadcaster.broadcast Array(player_ids), message
      end

    end
    
  end
end
