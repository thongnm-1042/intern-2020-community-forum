module PostsHelper
  def post_status status
    if status
      {
        css: Settings.status.on_status,
        status: t("post.index.on_status")
      }
    else
      {
        css: Settings.status.off_status,
        status: t("post.index.off_status")
      }
    end
  end

  def list_topics
    Topic.pluck :name, :id
  end

  def post_topic
    @post.topic.present? ? @post.topic.name : true
  end

  def get_all_user
    User.all
  end

  def get_all_topic
    Topic.all
  end
end
