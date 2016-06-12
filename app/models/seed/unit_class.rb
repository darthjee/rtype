class Seed::UnitClass < ActiveYaml::Base
  set_root_path 'config/active_hash'

  field :name
  field :slug
end

