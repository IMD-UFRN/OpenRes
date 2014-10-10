# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ObjectResource do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

end
