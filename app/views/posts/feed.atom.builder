atom_feed language: "ru-RU" do |feed|
  feed.title SETTINGS["title"]
  feed.updated @posts.first.updated_at unless @posts.empty?

  @posts.each do |post|
    next if post.updated_at.blank?

    feed.entry(post) do |entry|
      entry.url     post_url(post)
      entry.title   post.title

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
