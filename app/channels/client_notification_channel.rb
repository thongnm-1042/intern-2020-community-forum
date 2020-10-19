class ClientNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "client_notification_channel_#{params[:user_id]}"
  end
end
