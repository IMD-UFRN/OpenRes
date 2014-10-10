# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Reservation do
  it {should belong_to (:place)}

  it { should validate_presence_of(:begin_time) }
  it { should validate_presence_of(:end_time) }

  it { should validate_presence_of(:place_id) }

  it { should validate_presence_of(:user_id) }

end
