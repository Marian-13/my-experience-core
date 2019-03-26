#### What is `my-experience-core`?

From technical perspective `my-experience-core` is almost api-only Rails application (later simply `core`).

#### Format for json responses

JSend +
1. Keys of `data` have no nesting
2. Own error codes

[Link](https://github.com/omniti-labs/jsend)

#### Backed Urls

REST as Rails suggests + Additional POSTs for specific actions

[Link, view images](https://edgeguides.rubyonrails.org/routing.html)

#### How to run `my-experience` on production environment in local machine?

Comment in `config/database.yml`

```
username: my_experience
password: <%= ENV['MY_EXPERIENCE_DATABASE_PASSWORD'] %>
```

Only the first time run `$ RAILS_ENV=production bundle exec rake db:create`.
Then `$ RAILS_ENV=production bundle exec rake db:migrate`.
And if necessary `$ RAILS_ENV=production bundle exec rake db:seed`.

Every time run:
```
$ rm -rf public/assets/ public/packs/
$ RAILS_ENV=production bundle exec rake assets:precompile
$ RAILS_SERVE_STATIC_FILES=1 rails server -e production
```

Look at `log/production.log` if something goes wrong.

##### Command used to create this Rails application

`$ rails new my-experience --database=postgresql --skip-test --webpacker=react`

##### Command used to setup `react-rails`

`$ rails generate react:install`

##### Command used to setup `knock`

```
$ rails generate knock:install
$ rails generate knock:token_controller user
```
Do not forget to set `config.token_secret_signature_key = -> { Rails.application.credentials.fetch(:secret_key_base) }` in `config/initializers/knock.rb`

##### TODO

- Setup Rubocop
- rake task, which checks if gems are sorted alphabetically
- Dissalow `--force` on `master`
- Remove HACK for controller specs !!!!!!
- Remove HACK for autoloading Knock::Authenticable
- Structure of/for error codes
