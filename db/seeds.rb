# frozen_string_literal: true

zloty = Currency.create({ name: 'Zloty', code: 'PLN', number: 985 })
dollar = Currency.create({ name: 'US Dollar', code: 'USD', number: 840 })
euro = Currency.create({ name: 'Euro', code: 'EUR', number: 978 })
hryvnia = Currency.create({ name: 'Hryvnia', code: 'UAH', number: 980 })

CurrencyRate.create([
                      { from: dollar, to: euro, rate: 0.8155, source: 'Revolut' },
                      { from: euro, to: dollar, rate: 1.2007, source: 'Revolut' },
                      { from: zloty, to: dollar, rate: 0.2654, source: 'Revolut' },
                      { from: zloty, to: euro, rate: 0.2186, source: 'Revolut' },
                      { from: dollar, to: zloty, rate: 3.6842, source: 'Revolut' },
                      { from: euro, to: zloty, rate: 4.4682, source: 'Revolut' },
                      { from: hryvnia, to: dollar, rate: 0.0354, source: 'monobank'},
                      { from: hryvnia, to: euro, rate: 0.0292, source: 'monobank'},
                      { from: hryvnia, to: zloty, rate: 0.1317, source: 'monobank'},
                      { from: dollar, to: hryvnia, rate: 28.0, source: 'monobank'},
                      { from: euro, to: hryvnia, rate: 33.8, source: 'monobank'},
                      { from: zloty, to: hryvnia, rate: 7.41, source: 'monobank'}
                    ])
