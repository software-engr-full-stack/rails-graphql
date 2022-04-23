# A simple GraphQL server app

I built this app to learn about GraphQL. Starting from a newly generated Rails app:

1. Install `graphql`

    1. Add the line `gem 'graphql'` to your `Gemfile`

    2. `bundle install`

    3. `rails generate graphql:install`

2. Generate models

    1. `rails generate model ExampleModel name example_field`

    2. `rails generate model ExampleChildModel name example_field example_model:belongs_to`

    3. `rails db:migrate`

    4. Insert the line `has_many :example_child_models` inside the `ExampleModel` class in `app/models/example_model.rb`

    5. Seed database with example data. Replace the contents of `db/seed.rb` with the code below:
    ```ruby
    4.times do |num|
      nm = format 'model%02d', num
      model = ExampleModel.find_by(name: nm)
      model = ExampleModel.create!(name: nm) if !model

      4.times do |rnum|
        nm = format 'child_model%02d', rnum
        child_model = ExampleChildModel.find_by(model:, name: nm)

        ExampleChildModel.create!(model:, name: nm) if !child_model
      end
    end

    ```

    6. Seed the database: `rails db:seed`

3. Start the server: `rails server`

4. Create GraphQL queries

    1. `rails generate graphql:object example_model`

    2. `rails generate graphql:object example_child_model`

    2. Remove test code, extraneous comments, etc. from app/graphql/types/query_type.rb. Enter the following on the same file:

    ```ruby
    field :example_models, [Types::ExampleModelType], null: false, description: 'Get all example models.'

    def example_models
      ExampleModel.all
    end

    field :example_child_models, [Types::ExampleChildModelType], null: false, description: 'Get all example child models.'

    def example_child_models
      ExampleChildModel.all
    end
    ```

5. Test if the query works:

    1. Open your browser to [http://localhost:3000/graphiql](http://localhost:3000/graphiql)

    2. On the left pane, enter the following GraphQL query:

    ```graphql
    query {
      exampleModels {
        id
        name
        exampleChildModels{
          id
          name
        }
      }
    }
    ```

    3. Press the "execute query" button. The response shown on the right pane should show the ids and names of all example models. Under each example model, the ids and names of that example model's example child models should be shown.

# Usage

1. Clone this repo

2. `cd` into the clone directory

3. `bundle install`

4. `rails db:create db:migrate db:seed`

5. `rails server` This will run the server on port 3000 in the foreground.

6. Open your browser to [http://localhost:3000/graphiql](http://localhost:3000/graphiql)
