# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Place do

  it {should belong_to (:room_type)}

  it {should have_many (:object_resources)}

  it { should validate_presence_of(:name) }

end
