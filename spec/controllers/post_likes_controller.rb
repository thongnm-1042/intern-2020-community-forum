require "rails_helper"

RSpec.describe PostLikesController, type: :controller do
  let!(:user_1) {FactoryBot.create :user,
    created_at: "2020-09-06 05:48:12", role: "admin"}
  let!(:post_1) {FactoryBot.create :post}
  let(:valid_post_param) {FactoryBot.attributes_for :post}
  let(:invalid_post_param) {FactoryBot.attributes_for :post, name: nil}
  let!(:temp) {}

  describe "Login" do
    context "as a guest"  do
      before {logout user_1}
      before {post :create, params: valid_post_param}
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    context "as an  authenticated user" do
      before {login user_1}

      describe "POST #create" do
        context "when valid params" do
          it "should current user follow correct topic" do
            expect{
              post :create, xhr: true, params: {user_id: user_1.id, post_id: post_1.id}
            }.to change(PostLike, :count).by 1
          end

          it "should redirect to admin_posts_path" do
            post :create, xhr: true, params: {user_id: user_1.id, post_id: post_1.id}
            expect(response).to render_template :create
          end
        end
      end

      describe "DELETE #destroy" do
        let!(:post_like_destroy) {FactoryBot.create :post_like, user_id: user_1.id, post_id: post_1.id}

        context "when valid params" do
          before {delete :destroy, xhr: true, params: {id: post_like_destroy.id, post_id: post_1.id}}

          it "should correct name" do
            expect(PostLike.all).not_to include(post_like_destroy)
          end

          it "should redirect to admin_users_path" do
            expect(response).to render_template :destroy
          end
        end
      end
    end
  end
end
