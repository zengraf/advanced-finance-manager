# Advanced Finance Manager
Backend of the application for personal finance management, deep analytics and budget monitoring.

Frontend: [Advanced Finance Frontend](https://github.com/zengraf/advanced-finance-frontend)

## Usage

- Install `Ruby v2.7.1` with [rvm](https://rvm.io) or [asdf-vm](http://asdf-vm.com/)
- Install [`node.js`](https://nodejs.org/en/)
- Install [`PostgresQL`](https://www.postgresql.org) and start the server
- Go to project's directory
- Run `bundle install`
- Create `.env` file in the project directory
- Set `DEVISE_JWT_SECRET_KEY` environment variable in `.env` file
  - You can generate the value with `bin/rake secret`
- Run `bin/rails db:setup`
- Run `bin/rails s -b 0.0.0.0 -p 3001`
- Run `sudo python -m smtpd -n -c DebuggingServer localhost:25` to receive e-mails or read them from `stdout`
- Visit http://localhost:3001/api-docs to see the documentation and test the functionality

## Who did what

### Illia Andrieiev ([k4wel](https://github.com/k4wel))

- Login and registration
  - [application_controller.rb](app/controllers/application_controller.rb)
  - Certain [devise views](app/views/devise)
  - Part of [application.html.erb](app/views/layouts/application.html.erb)
  - [JWT configuration](/config/initializers/devise.rb) with [JTI revocation strategy](https://github.com/waiting-for-dev/devise-jwt#jtimatcher)
- Account e-mail confirmation
  - Certain [devise views](app/views/devise)
  - Part of [development.rb](config/environments/development.rb) config
- Currency section
  - [index.html.erb](app/views/currencies/index.html.erb) and [new.html.erb](app/views/currencies/new.html.erb) views
  - Part of [currencies_controller.rb](app/controllers/currencies_controller.rb)
  - Part of [currency.rb](app/models/currency.rb) model
- Currency rates
  - [show.html.erb](app/views/currencies/show.html.erb) view
  - Part of [currencies_controller.rb](app/controllers/currencies_controller.rb)
- Handle migration to API-only
- Controllers
  - [accounts_controller.rb](app/controllers/accounts_controller.rb)
  - [areas_controller.rb](app/controllers/areas_controller.rb)
  - [categories_controller.rb](app/controllers/categories_controller.rb)
  - [analytics_controller.rb](app/controllers/analytics_controller.rb)

### Bohdan Samotys ([Samotys](https://github.com/Samotys))

- Database seeds (currencies, rates)
  - [seeds.rb](db/seeds.rb)
- Website navbar
  - Part of [application.html.erb](app/views/layouts/application.html.erb)
- Transactions section
  - [transactions_controller.rb](app/controllers/transactions_controller.rb)
  - [Views](app/views/transactions)
  - Part of [user.rb](app/models/user.rb) model
- Accounts section
  - [accounts_controller.rb](app/controllers/accounts_controller.rb)
  - [Views](app/views/accounts)

### Hlib Hraif ([zengraf](https://github.com/zengraf))

- Create Ruby on Rails project base
  - [Gemfile](Gemfile)
  - [database.yml](config/database.yml) config
- Setup Webpack and Bootstrap
  - [package.json](package.json)
  - [application.js](app/javascript/packs/application.js)
- Database migrations
  - [Migrations](db/migrate)
- Model relationships
  - [Models](app/models)
- Controllers
  - [transactions_controller.rb](app/controllers/transactions_controller.rb)
  - [user_controller.rb](app/controllers/user_controller.rb)
- API documentation
  - [swagger.yaml](public/api-docs/v1/swagger.yaml) – OpenAPI specification
  - [rswag.rb](config/initializers/rswag-ui.rb)
- Monobank API wrapper
  - [monobank_api.rb](lib/monobank_api.rb)
- Pagination support
  - [pagy.rb](config/initializers/pagy.rb)
- CORS configuration
  - [cors.rb](config/initializers/cors.rb)
- Active Storage configuration
  - [Migration](db/migrate/20210613182933_create_active_storage_tables.active_storage.rb)
- Additional seeds
  - [seeds.rb](db/seeds.rb)

### Collectively

- Project idea
- [Project description](description_pl.pdf)
- [Sketches](design.sketch)
- [Database structures](https://dbdiagram.io/d/600f002780d742080a37c8fb) and [diagrams](diagrams.mdj)
- This [README.md](README.md)