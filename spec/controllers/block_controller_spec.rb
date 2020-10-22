require "rails_helper"

RSpec.describe Admin::BlockController, type: :controller do
  let!(:test_post) {FactoryBot.create :post}
  let!(:user_1) {FactoryBot.create(:user, :set_user, role: :admin)}
  let!(:user_2) {FactoryBot.create(:user, :set_user, role: :member)}

  describe "PATCH #update" do
    context "as a guest"  do
      before {logout user_1}
      before {patch :update, params: {id: user_1.id}}
      it {expect(response).to redirect_to new_user_session_path(locale: nil)}
    end

    before {login user_1}

    context "when valid params user block" do
      before {patch :update,  params: {id: user_1.id}}

      it "should correct title" do
        expect(assigns(:user).status).to eq "block"
      end

      it "should redirect admin_posts_path" do
        expect(response).to redirect_to admin_users_path
      end
    end

    context "when valid params user active" do
      before {patch :update,  params: {id: user_2.id}}

      it "should correct title" do
        expect(assigns(:user).status).to eq "block"
      end

      it "should redirect admin_posts_path" do
        expect(response).to redirect_to admin_users_path
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: user_1.name}}

      it "should a invalid post" do
        expect(assigns(:user).nil?).to eq true
      end

      it "should redirect admin_posts_path" do
        expect(response).to redirect_to admin_root_path
      end
    end
  end
end
