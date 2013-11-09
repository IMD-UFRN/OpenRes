require 'spec_helper'

describe Sector do
  it {should have_many (:users)} 
  it {should have_many (:places)} 
  it {should have_many (:object_resources)} 

  it {should validate_presence_of (:name)}  

end
