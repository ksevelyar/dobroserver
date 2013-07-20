module Slug
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug
  end

  def to_param
    slug
  end

  def generate_slug
    source = defined?(title) ? title : name
    self.slug = Translit.slug(source)
  end
end
