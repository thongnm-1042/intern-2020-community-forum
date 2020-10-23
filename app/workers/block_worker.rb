class BlockWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform profile
    @user = User.find profile
    BlockMailer.send("#{@user.status}_email", @user).deliver
  end
end
