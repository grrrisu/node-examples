module MessageHandler

  class Test < Base

    def reverse text
      queue Event::Test.new(player.id, text)
    end

    def direct_reverse text
      text.reverse
    end

  end

end
