
FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    password 'foobar00'
    email 'john.doe@foo.bar'
  end
end
