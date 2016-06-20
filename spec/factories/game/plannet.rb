FactoryGirl.define do
  factory :plannet, class: Game::Plannet do
    sequence(:name) { |n| '%04d' % n }
  end
end

