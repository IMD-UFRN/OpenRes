# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:role) }

  it { should ensure_inclusion_of(:role).in_array(%w(admin sector_admin secretary basic)) }
  it { should validate_uniqueness_of(:cpf) }

  it { should have_many(:reservations) }
  it { should have_many(:sectors) }
end
