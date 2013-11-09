# -*- encoding : utf-8 -*-
RSpec::Matchers.define :have_a_valid_factory do
  match do |subject|
    factory = subject.class.name.underscore.to_sym
    FactoryGirl.build(factory).should be_valid
  end
end
