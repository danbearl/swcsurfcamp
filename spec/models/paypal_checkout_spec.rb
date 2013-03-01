require 'spec_helper'

describe PaypalCheckout do

  let(:reservation) do
    double(id: 4, camp_price: 50.00, camp_type: "weekday", camp_start_date: Time.now)
  end

  describe "#url" do
    it "returns the paypal url for checking out" do
      order = described_class.new(reservation, '0.0.0.0')
      order.url.should_not be_blank
    end
  end
end
