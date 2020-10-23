require "rails_helper"

RSpec.describe FavoritesController, type: :controller do
  let!(:user_1) {FactoryBot.create :user, role: "admin"}

  describe "GET #index" do
    before {get :index, params: {user_id: user_1.id}}

    context "as a guest"  do
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    context "as an  authenticated user" do
      let!(:post_1) {FactoryBot.create :post}
      let!(:post_mark_1) {FactoryBot.create :post_mark,
        user_id: user_1.id, post_id: post_1.id}

      before {login user_1}

      before {get :index, params: {user_id: user_1.id}}

      it {expect(response).to render_template :index}

      it {expect(assigns(:posts).pluck(:id)).to eq [post_1.id]}
    end
  end
end
