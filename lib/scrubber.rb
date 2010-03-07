[
  "field_transform",
  "job",
  "worker"
].each do |file|
  require "scrubber/#{file}"
end

module Scrubber
  def self.perform(&block)
    worker = Scrubber::Worker.new
    worker.instance_eval(block)
    worker.perform
  end
end
