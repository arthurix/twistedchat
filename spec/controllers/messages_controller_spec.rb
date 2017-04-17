RSpec.describe MessagesController, :type => :controller  do

  describe 'GET #index' do
    render_views

    context 'when user is logged in' do
      before do
        allow(controller).to receive(:logged_in?).and_return true
        get :index
      end
      it 'renders the chat area' do
        expect(response.body).to match(/Chat/m)
      end

      context 'when page load finish' do
        it "register user activity" do
          get :activity, params: { message: { status: 'activate' } }, xhr: true
          expect(response).to have_http_status(:no_content)
        end
      end
    end

    context 'when user is logged out' do
      before do
        allow(controller).to receive(:logged_in?).and_return false
        get :index
      end
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to login_path }
    end
  end

  describe 'POST #create' do
    let(:current_username) { 'batman' }
    let(:current_dialect) { User::DIALECTS.sample }
    let(:text) { "I'm Batman" }

    before do
      @request.session[:username] = current_username
      @request.session[:dialect] = current_dialect
      allow(controller).to receive(:logged_in?).and_return true
    end

    context 'when user send a message' do
      let(:params) { { message: { username: current_username, text: text } } }
      before { post :create, params: params }

      it { expect(response).to have_http_status(:ok) }
    end
  end
end
