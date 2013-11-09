require 'spec_helper'

describe Place do
  it {should belong_to (:sector)} 
  
  it {should have_many (:object_resources)}

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:sector_id) }

  it { should have_a_valid_factory }
end
