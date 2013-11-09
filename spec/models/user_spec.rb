require 'spec_helper'

describe User do
  it {should belong_to (:sector)} 
  it {should have_many (:reservations)} 

  it {should validate_presence_of (:name)}
  it {should validate_presence_of (:cpf)}

end
