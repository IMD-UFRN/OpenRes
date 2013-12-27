# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:sector_id) }
  it { should ensure_inclusion_of(:role).in_array(%w(admin sector_admin secretary basic)) }
  it { should validate_uniqueness_of(:cpf) }

  it { should belong_to(:sector) }
  it { should have_many(:reservations) }
end
