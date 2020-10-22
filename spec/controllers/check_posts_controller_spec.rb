require "rails_helper"

RSpec.describe Admin::CheckPostsController, type: :controller do
  let!(:test_post) {FactoryBot.create :post}
  let!(:user_1) {FactoryBot.create :user,
    created_at: "2020-09-06 05:48:12", role: "admin"}

  describe "PATCH #update" do
    context "as a guest"  do
      before {logout user_1}
      before {patch :update, params: {post_ids: test_post.id}}
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    before {login user_1}

    context "when valid params" do
      before {patch :update, params: {post_ids: test_post.id, commit: "on"}}

      it "should correct title" do
        expect(assigns(:posts).first.status).to eq "on"
      end

      it "should redirect admin_posts_path" do
        expect(response).to redirect_to admin_posts_path
      end
    end

    context "when invalid params" do
      before { patch :update, params: {post_ids: test_post.name, commit: "on"}}

      it "should a invalid post" do
        expect(assigns(:post).nil?).to eq true
      end

      it "should redirect admin_posts_path" do
        expect(response).to redirect_to admin_posts_path
      end
    end
  end
end
