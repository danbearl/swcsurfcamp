require 'spec_helper'

describe PaypalCheckout do

  let(:reservation) do
    double(id: 4, camp_price: 50.00, camp_type: "weekday", camp_start_date: Time.now)
  end
  
  PaypalLogin.signature = ENV['PAYPAL_TEST_SIGNATURE']
  PaypalLogin.login = ENV['PAYPAL_TEST_LOGIN']
  PaypalLogin.password = ENV['PAYPAL_TEST_PASSWORD']

  describe "#url" do
    it "returns the paypal url for checking out" do
      order = described_class.new(reservation, '0.0.0.0', "www.swcsurfcamp.com")
      order.url.should_not be_blank
    end
  end
end
