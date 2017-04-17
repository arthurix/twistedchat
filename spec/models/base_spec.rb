RSpec.describe Base, :type => :model do
  subject { described_class.new(message, dialect) }

  describe '#response' do
    let(:message) { 'I\'m Batman' }
    let(:dialect) { User::DIALECTS.sample }

    context 'when requesting API' do
      it { expect(subject.response.code).to eq(200) }

      it 'should send post request' do
        expect(subject.response.request.method).to eq('post')
      end
      it 'should return something' do
        expect(subject.response.body).to_not be_empty
      end
      it 'should call the correct API url' do
        expect(subject.response.request.url).to eq(API[:base_uri])
      end
    end
  end
end
