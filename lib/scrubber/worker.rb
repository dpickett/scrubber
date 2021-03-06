module Scrubber
  class Worker
    attr_reader :jobs

    def initialize
      @jobs = [] 
    end

    def scrub_table(table_name, options = {})
      @jobs << Scrubber::Job.new(table_name, options)
      yield(@jobs.last)
    end

    def perform
      @jobs.each{|j| j.perform}
    end
  end
end
