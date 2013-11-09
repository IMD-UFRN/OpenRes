require 'spec_helper'

describe ObjectResource do
  it {should belong_to (:sector)} 
  it {should belong_to (:place)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:sector_id) }
  it { should validate_presence_of(:place_id) }

  it { should have_a_valid_factory }
end
