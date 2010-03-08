require 'spec_helper'

describe "scrubbing" do
  it 'should set the first users email to have an example.com domain' do
    perform_scrub
    User.first.email.should =~ /example.com/
  end

  it 'should not perform scrubbing on a mydomain.com email due to the unless proc' do
    u = User.create! do |u|
      u.first_name = "Davie"
      u.last_name  = "Crocket"
      u.login      = "racoon"
      u.email      = "davie@mydomain.com"
    end

    perform_scrub

    u.reload
    u.email.should =~ /mydomain.com/
  end

  def perform_scrub
    Scrubber.perform do |s|
      s.scrub_table :users, :unless => proc {|user| user.email =~ /mydomain.com/i } do |user|
        user.scrub :email, :set_to => "user[:id]@example.com"
        user.scrub :last_name, :set_to => "blank"
      end
    end

  end
end
