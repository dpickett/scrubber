require 'rubygems'
require 'active_support'
require 'active_record'

[
  'field_transform',
  'job',
  'worker'
].each do |file|
  require "scrubber/#{file}"
end

module Scrubber
  def self.perform(&block)
    worker = Scrubber::Worker.new
    yield(worker)
    worker.perform
  end
end
