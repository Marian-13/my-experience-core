#### What is `my-experience`?

From technical perspective `my-experience` is a full-stack Rails application with React frontend (later simply `front`).
In order to disallow access to `front` code for unathenticated users, `front` was splitted into two separate React apps: `landing` and actually `front`.

#### How to see, which files are included in bundle?

1. Open `app/javascript/packs/front.js` (or `app/javascript/packs/landing.js`, or both)
2. Add the following line after `ReactRailsUJS.useContext(context);`
```
console.log(context.keys());
```

#### How to add npm package?

Exaple of adding `materialize-css`

1. `$ yarn add materialize-css`
2. Add the following to `app/javascript/packs/front.js` (or `app/javascript/packs/landing.js`, or both)

```
require('materialize-css/dist/css/materialize.css');
require('materialize-css/dist/js/materialize.js');
```

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

##### TODO

- Remove `turbolinks`?
- Remove `Asset Pipeline`?
- Setup Rubocop
- Setup JSLint
- rake task, which checks if gems are sorted alphabetically
- Congure webpack to simplify imports
- Dissalow `--force` on `master`
- Use CDN in production?
- Fonts?
- Remove HACK for controller specs !!!!!!
