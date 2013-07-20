if Rails.env.development?
  User.create(name: "admin",
              email: "admin@domain.tld",
              password: "password",
              password_confirmation: "password",
              admin: true)

  post = Post.create(raw_content: "description #cut article",
              title: "Тестовый пост",
              published_at: Time.now,
              published: true)

  post.tags.create(name: "test_tag")

  Comment.create(name: "admin",
                 blog_record_id: post.id,
                 email: "ksevelyar@yandex.ru",
                 content: "test_comment",
                 ip: "127.0.0.1")
end
