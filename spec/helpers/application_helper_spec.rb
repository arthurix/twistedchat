RSpec.describe ApplicationHelper, :type => :helper do

  describe ".current_user" do
    let(:current_username) { 'barry' }
    let(:current_dialect) { User::DIALECTS.sample }
 

    context 'when session username was registered' do
      before do
        @request.session[:username] = current_username
        @request.session[:dialect] = current_dialect
      end

      it "return current_user" do
        expect(helper.current_user).to eq(current_user)
      end
      it "return current_dialect" do
        expect(helper.current_dialect).to eq(current_dialect)
      end
    end

    context 'when session was not registered' do
      it "not return current_user" do
        expect(helper.current_user).to be_nil
      end
      it "not return current_user" do
        expect(helper.current_dialect).to be_nil
      end
    end
  end
end
