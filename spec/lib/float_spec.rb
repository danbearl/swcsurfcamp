require './lib/float_extensions'

describe Float do

  subject { 4.4 }

  describe "#to_cents" do
    it 'converts itself to cents' do
      subject.to_cents.should == 440
    end
  end

end
