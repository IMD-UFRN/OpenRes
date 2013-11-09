require 'spec_helper'

describe RoomType do
  it {should have_many (:places)} 

  it {should validate_presence_of (:name)} 
  it {should validate_presence_of (:description)} 

  it { should have_a_valid_factory }
end
