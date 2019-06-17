# frozen_string_literal: true

if Rails.env.development?
  user = User.create(name: 'admin',
                     email: 'admin@domain.tld',
                     password: 'password',
                     password_confirmation: 'password',
                     admin: true)

  post = user.posts.create(raw_content: 'Hello world #cut article',
                           title: 'Test post',
                           published_at: Time.now,
                           published: true)

  post.tags.create(name: 'ruby')

  Comment.create(name: 'admin',
                 blog_record_id: post.id,
                 email: 'ksevelyar@yandex.ru',
                 content: 'test comment',
                 ip: '127.0.0.1')
end
