# Be sure to restart your server when you modify this file.

Dobroserver::Application.config.session_store :cookie_store, key: '_dobroserver_session',
                                                             expire_after: 10.years
