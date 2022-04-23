# frozen_string_literal: true

module Types
  class ResourceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :data, GraphQL::Types::JSON
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
