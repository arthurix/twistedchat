RSpec.describe MessagesHelper, :type => :helper do

  describe ".chat_side" do
    let(:current_username) { 'barry' }
    let(:another_username) { 'jay' }
 
    before { @request.session[:username] = current_username }

    context 'when current user send a message' do
      it "should append user message to the left" do
        expect(helper.chat_side(current_username)).to eq('left')
      end
    end

    context 'when current user receive a message' do
      it "should append user message to the right" do
        expect(helper.chat_side(another_username)).to eq('right')
      end
    end
  end

  describe ".time" do
    let(:created_at) { DateTime.parse("2017-04-10 10:30:14") }

    context 'when a message is appended' do
      it "should render correct time format" do
        expect(helper.time(created_at)).to eq('10/Apr/2017 10:30:14')
      end
    end
  end
end
