require "spec_helper"

describe ReservationApprovalMailer do
  describe "approved_mail" do
    let(:mail) { ReservationApprovalMailer.approved_mail }

    it "renders the headers" do
      mail.subject.should eq("Approved mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "rejected_mail" do
    let(:mail) { ReservationApprovalMailer.rejected_mail }

    it "renders the headers" do
      mail.subject.should eq("Rejected mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "suspended_mail" do
    let(:mail) { ReservationApprovalMailer.suspended_mail }

    it "renders the headers" do
      mail.subject.should eq("Suspended mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
