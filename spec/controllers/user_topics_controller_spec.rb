require "rails_helper"

RSpec.describe UserTopicsController, type: :controller do
  let!(:user_1) {FactoryBot.create :user,
    created_at: "2020-09-06 05:48:12", role: "admin"}
  let!(:topic_1) {FactoryBot.create :topic}
  let(:valid_topic_param) {FactoryBot.attributes_for :topic}
  let(:invalid_topic_param) {FactoryBot.attributes_for :topic, name: nil}
  let!(:temp) {}

  describe "Login" do
    before {logout user_1}
    before {post :create, params: valid_topic_param}
    context "as a guest"  do
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    context "as an  authenticated user" do
      before {login user_1}

      describe "POST #create" do
        context "when valid params" do
          it "should current user follow correct topic" do
            expect{
              post :create, xhr: true, params: {user_id: user_1.id, topic_id: topic_1.id}
            }.to change(UserTopic, :count).by 1
          end

          it "should redirect to admin_posts_path" do
            post :create, xhr: true, params: {user_id: user_1.id, topic_id: topic_1.id}
            expect(response).to render_template :create
          end
        end
      end

      describe "DELETE #destroy" do
        let!(:user_topic_destroy) {FactoryBot.create :user_topic, user_id: user_1.id, topic_id: topic_1.id}

        context "when valid params" do
          before {delete :destroy, xhr: true, params: {id: user_topic_destroy.id, topic_id: topic_1.id}}

          it "should correct name" do
            expect(UserTopic.all).not_to include(user_topic_destroy)
          end

          it "should redirect to admin_users_path" do
            expect(response).to render_template :destroy
          end
        end
      end
    end
  end
end
