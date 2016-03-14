module MessageHandler

  class Base

    attr_reader :player

    def initialize player
      @player = player
    end

    def dispatch message
      send message[:action], *Array(message[:args])
    end

  end

end
