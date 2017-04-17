RSpec.describe User, :type => :model do
  subject { described_class.new }

  context 'when have constant DIALECTS' do
    it { expect(described_class::DIALECTS).to be_an(Array) }
    it { expect(described_class::DIALECTS)
           .to include('yoda','valley','binary')
    }
  end

  context 'when validating presence' do
    [:username, :dialect].each do |field|
      describe "##{field}" do
        let(:error_message) { subject.errors[field].join }
        it "can't be blank" do
          expect(subject.valid?).to be_falsey
          expect(error_message).to include("can't be blank")
        end

      end
    end
  end

  describe '#username' do
    let(:error_message) { subject.errors[:username].join }

    it "is too long (maximum is 15 characters)" do
      subject.username = "my_very_long_username"
      expect(subject.valid?).to be_falsey
      expect(error_message).to include("maximum is 15 characters")
    end

    it "format is invalid" do
      subject.username = "invalid username"
      expect(subject.valid?).to be_falsey
      expect(error_message).to include("is invalid")
    end
  end

  describe '#dialect' do
    let(:error_message) { subject.errors[:dialect].join }

    it "is not included in the list" do
      subject.dialect = "another_dialect"
      expect(subject.valid?).to be_falsey
      expect(error_message).to include("is not included in the list")
    end
  end

  describe '#username_already_taken' do
    let(:error_message) { subject.errors[:username].join }
    let(:online_username) { 'spiderman' }
    let(:activity) { [ { username: online_username, status: 'activate'} ] }
    before do
      allow(UserActivity).to receive(:active).and_return(activity)
    end

    it 'username spiderman has already been taken' do
      subject.username = online_username
      expect(subject.valid?).to be_falsey
      expect(error_message)
        .to include("#{online_username} has already been taken")
    end
  end
end
