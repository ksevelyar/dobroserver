# frozen_string_literal: true

class Space < Redcarpet::Render::HTML
  def preprocess(text)
    spoilers text
  end

  def spoilers(text)
    text.gsub!(/^\+(.+)\n+([\s\S]*?)\n^\+/,
               '<div class="spoiler_title plus">\1</div><div class="spoiler_body">\2</div>')
    text
  end

  def header(text, level)
    level += 1
    slug = Translit.slug(text)
    anchor = %( <a href="##{slug}" class="anchor">#</a>)

    "<h#{level} id=#{slug}>#{text + anchor}</h#{level}>"
  end
end
