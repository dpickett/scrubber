require 'spec_helper'

describe Scrubber::Worker do
  before(:each) do
    @worker = Scrubber::Worker.new
    @worker.scrub_table :some_table do |t|

    end
  end

  it 'should have a job' do
    @worker.jobs.size.should eql(1)
  end
end
