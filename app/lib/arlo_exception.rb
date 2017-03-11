module ArloException
  class Base < StandardError
    attr_reader :message, :code

    def initialize(msg: 'Something wrong', code: 999)
      @message = msg
      @code = code
    end
  end

  class ClientApiError < Base
    def code
      502
    end

    def message
      'Arlo server is not responding'
    end
  end
end