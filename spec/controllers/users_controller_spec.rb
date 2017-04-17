RSpec.describe UsersController, :type => :controller  do

  describe 'GET #login' do
    context 'when user is logged in' do
      before do
        allow(controller).to receive(:logged_in?).and_return true
        get :new
      end
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to messages_path }
    end

    context 'when user is logged out' do
      before do
        allow(controller).to receive(:logged_in?).and_return false
        get :new
      end
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('users/new') }
      it { expect(response).to render_template('layouts/user') }
    end
  end

  describe 'POST #login' do
    let(:params) { { user: { username: username, dialect: dialect } } }
    context 'when user try to loggin with valid username and dialect' do
      let(:username) { 'batman' }
      let(:dialect) { User::DIALECTS.sample }

      before { post :create, params: params }

      it { expect(request.session).to include(['username', username]) }
      it { expect(request.session).to include(['dialect', dialect]) }
      it { expect(controller.logged_in?).to be_truthy }
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to messages_path }
      it { expect(response).to redirect_to messages_path }
    end

    context 'when user try to loggin without username and dialect' do
      let(:username) { nil }
      let(:dialect) { nil }

      before { post :create, params: params }

      it { expect(controller.logged_in?).to be_falsey }
      it { expect(flash[:alert]).not_to be_empty }
      it { expect(response).to render_template('users/new') }
    end
  end

  describe 'DELETE #logout' do
    context 'when user is logged in' do
      let(:username) { 'batman' }
      let(:dialect) { User::DIALECTS.sample }

      before do
        @request.session[:username] = username
        @request.session[:dialect] = dialect
      end

      it 'should be online' do
        expect(controller.logged_in?).to be_truthy
      end

      context 'when user try to loggout' do
        before do
          delete :destroy
        end

        it { expect(response).to have_http_status(:redirect) }
        it { expect(response).to redirect_to root_path }
        it { expect(request.session).to be_empty }
        it 'should be offline' do
          expect(controller.logged_in?).to be_falsey
        end
      end
    end
  end

end
