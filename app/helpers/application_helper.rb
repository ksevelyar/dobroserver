module ApplicationHelper
  def text_date date
    (date || Time.zone.now).strftime('%Y.%m.%d %H:%M')
  end

  def gravatar_for email
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=46"
    image_tag(gravatar_url, class: "avatar", alt: "")
  end

  def space text
    renderer = Space.new(hard_wrap: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end
