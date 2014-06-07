atom_feed language: "ru-RU" do |feed|
  feed.title SETTINGS["title"]
  feed.updated @posts.pluck(:published_at).first if @posts.any?

  @posts.each do |post|
    feed.entry(post,
               published: post.published_at,
               updated:   post.published_at) do |entry|

      entry.title     post.title

      if post.description?
        link = link_to "Читать дальше ›", post_url(post, anchor: "cut")
        entry.content space(post.description) + raw("<p>#{link}</p>"), type: 'html'
      else
        entry.content space(post.content), type: 'html'
      end

      entry.author do |author|
        author.name post.user.name
      end
    end
  end
end
