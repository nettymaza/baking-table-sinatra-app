# Baking Table

This Sinatra app was created with the passionate baker in mind. You can create a baker account to store all your favorite baking recipes, view them by category, share them with a community of bakers who are looking for fresh new recipe ideas, and gather inspiration from other's creative work in the kitchen. You will also have the option to edit and delete your own recipes and view them by category.

## Installation

Please make sure to install homebrew, follow instructions from this link https://docs.brew.sh/Installation.html

To install sqlite3 `brew install sqlite`

And then execute:

`bundle install`

Create the database:

`rake db:create`

To run migrations:

`rake db:migrate`

To seed data:

`rake db:seed`

## Contributing

The app is available as open source under the terms of the <a href="https://opensource.org/licenses/MIT">MIT License</a>

Bug reports and pull requests are welcome on GitHub at https://github.com/nettymaza/baking-table-sinatra-app.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the <a href="https://www.contributor-covenant.org/">Contributor Covenant</a> code of conduct.
