# -*- encoding : utf-8 -*-
require "spec_helper"

describe NotifyUserMailer do
  describe "reservation_made" do
    let(:mail) { NotifyUserMailer.reservation_made }

    it "renders the headers" do
      mail.subject.should eq("Reservation made")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
