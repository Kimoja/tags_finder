# frozen_string_literal: true

# :nodoc:
class TagsFinder
  # :nodoc:
  class Job
    attr_reader :pid

    def initialize(&block)
      @block = block
      @read, @write = IO.pipe
    end

    def call
      @pid = fork do
        @read.close
        @write.write(Marshal.dump(@block.call))
      end

      self
    end

    def result
      @write.close
      res = @read.read
      res.empty? ? nil : Marshal.load(res)
    end
  end
end
