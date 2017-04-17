RSpec.describe Message, :type => :model do
  subject do
    described_class.new( username: username, text: text, dialect: dialect)
  end

  describe '#translate' do
    let(:username) { 'flash' }
    let(:text) { 'My name is Barry Allen, and I am the fastest man alive' }

    context 'when dialect is yoda' do
      let(:dialect) { 'yoda' }
      let(:translated) do
        'The fastest man alive, my name is, barry Allen, and I am'
      end

      it 'dispatch Yoda class' do
        expect(subject.dispatch).to be_an_instance_of(Yoda)
      end

      it 'translate message to yoda dialect' do
        expect(subject.translate).to eq( translated )
      end
    end

    context 'when dialect is valley' do
      let(:dialect) { 'valley' }
      let(:translated) do
        'My name is like totally Barry Allen, and I am the fastest man alive'
      end

      it 'dispatch Valley class' do
        expect(subject.dispatch).to be_an_instance_of(Valley)
      end

      it 'translate message to valley dialect' do
        expect(subject.translate).to eq( translated )
      end
    end

    context 'when dialect is binary' do
      let(:dialect) { 'binary' }
      let(:translated) do
        '10011011111001 1101110110000111011011100101 11010011110011 10000101' \
        '100001111001011100101111001 100000111011001101100110010111011101011' \
        '00 110000111011101100100 1001001 11000011101101 1110100110100011001' \
        '01 1100110110000111100111110100110010111100111110100 11011011100001' \
        '1101110 11000011101100110100111101101100101'
      end

      it 'dispatch Binary class' do
        expect(subject.dispatch).to be_an_instance_of(Binary)
      end

      it 'translate message to binary dialect' do
        expect(subject.translate).to eq( translated )
      end
    end
  end

  describe '#mentions' do
    let(:username) { 'batman' }
    let(:mentioned) { 'superman' }
    let(:dialect) { User::DIALECTS.sample }
    let(:text) { "I Want you to remember the one Man who beat you @#{mentioned}" }

    context 'when Batman mentioned Superman' do
      let(:activity) { [ { username: mentioned, status: 'activate'} ] }
      before do
        allow(UserActivity).to receive(:active).and_return(activity)
      end

      it 'Superman is online' do
        expect(subject.mentions).to include(activity)
      end

      it 'Batman mention superman in text message using @' do
        expect(subject.scanned_mentions).to eq(Array(mentioned))
      end
    end
  end
end
