require 'spec_helper'

describe Scrubber::Job do
  before(:each) do
    @table_name = :users
    @job = Scrubber::Job.new(@table_name, :unless => proc {|user| user.email != "farfig" })
  end

  it 'should have a table name' do
    @job.table_name.should eql(@table_name.to_s)
  end

  it 'should have a conditional proc' do
    @job.conditional_proc.should_not be_nil
  end

  it 'should have a conditional proc type of unless' do
    @job.conditional_proc_type.should eql(:unless)
  end

  it 'should append to the list of field transforms when I specify a scrub' do
    @job.scrub(:email, :set_to => nil)
    @job.field_transforms.size.should eql(1)
  end
end
