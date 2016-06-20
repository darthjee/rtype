FactoryGirl.define do
  factory :participant, class: Game::Battle::Participant do
    division
    event
    role 'attacker'
  end
end


