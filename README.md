# Advanced Finance Manager
An application for personal finance management, deep analytics and budget monitoring.

## Who did what

### Illia Andrieiev ([k4wel](https://github.com/k4wel))

- Login and registration
  - [application_controller.rb](app/controllers/application_controller.rb)
  - Certain [devise views](app/views/devise)
  - Part of [application.html.erb](app/views/layouts/application.html.erb)
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

### Collectively

- Project idea
- [Project description](description_pl.pdf)
- [Sketches](design.sketch)
- [Database structures](https://dbdiagram.io/d/600f002780d742080a37c8fb) and [diagrams](diagrams.mdj)
- This [README.md](README.md)