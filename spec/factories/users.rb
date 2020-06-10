# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John' }
    email { 'user@test.com' }
    password { 'Doe' }
  end
end
