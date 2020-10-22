require "rails_helper"

RSpec.describe TrendsController, type: :controller do
  let!(:user_1) {FactoryBot.create :user}

  describe "GET #index" do
    before {get :index}

    context "as a guest"  do
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    context "as an  authenticated user" do
      let!(:user_3) {FactoryBot.create :user}
      let!(:topic_1) {FactoryBot.create :topic}

      before do
        login user_1
        get :index
      end

      it {expect(response).to render_template :index}

      it {expect(assigns(:users).pluck(:id)).to eq [user_3.id]}
      it {expect(assigns(:topics).pluck(:id)).to eq [topic_1.id]}
    end
  end
end
