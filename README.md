#### What is `my-experience`?

From technical perspective `my-experience` is a full-stack Rails application with React frontend (later simply `front`).
In order to disallow access to `front` code for unathenticated users, `front` was splitted into two separate React apps: `landing` and actually `front`.

##### Command used to create this Rails application

`$ rails new my-experience --database=postgresql --skip-test --webpacker=react`

##### Command used to setup `react-rails`

`$ rails generate react:install`

##### TODO

- Remove `turbolinks`?
- Remove `Asset Pipeline`?
- Setup Rubocop
- Setup JSLint
