require "spec_helper"

describe MailMan do
  describe "confirmation" do
    let(:mail) { MailMan.confirmation }

    it "renders the headers" do
      mail.subject.should eq("Confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "three_week_reminder" do
    let(:mail) { MailMan.three_week_reminder }

    it "renders the headers" do
      mail.subject.should eq("Three week reminder")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "two_week_reminder" do
    let(:mail) { MailMan.two_week_reminder }

    it "renders the headers" do
      mail.subject.should eq("Two week reminder")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "last_minute_reminder" do
    let(:mail) { MailMan.last_minute_reminder }

    it "renders the headers" do
      mail.subject.should eq("Last minute reminder")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
