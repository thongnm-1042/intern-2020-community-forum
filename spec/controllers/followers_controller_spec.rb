require "rails_helper"

RSpec.describe FollowersController, type: :controller do
  let!(:user_1) {FactoryBot.create :user, role: "admin"}

  describe "GET #index" do
    before {get :index, params: {user_id: user_1.id}}

    context "as a guest"  do
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    context "as an  authenticated user" do
      before {login user_1}

      before {get :index, params: {user_id: user_1.id}}

      it {expect(response).to render_template :index}

      it {expect(assigns(:user).id).to eq user_1.id}
    end
  end
end
