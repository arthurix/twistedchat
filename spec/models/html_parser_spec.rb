RSpec.describe HtmlParser, :type => :model do
  subject { described_class.new(raw_text) }

  describe '#search' do
    let(:raw_text) { "Your Words in YODA</h3><blockquote><p>\n The fastest " \
      "man alive, my name is, Barry Allen, and I am </p></blockquote></td><" \
      "/tr></table>uhoh, no footer."
    }
    let(:expected_text) {
      'The fastest man alive, my name is, Barry Allen, and I am'
    }

    context 'when receive raw html text' do
      let(:tag) { 'blockquote' }

      it 'return the expected text extracted from tag' do
        expect(subject.search(tag)).to eq(expected_text)
      end
    end
  end
end
