require 'spec_helper'

describe Scrubber::FieldTransform do
  before(:each) do
    @field_name = :email
    @transform  = Scrubber::FieldTransform.new(@field_name, :change_to => nil)
  end

  it 'should have a field' do
    @transform.field.should eql(@field_name.to_s)
  end

  it 'should raise an error if I do not specify a change_to param' do
    lambda { Scrubber::FieldTransform.new(@field_name) }.should raise_error
  end
end
