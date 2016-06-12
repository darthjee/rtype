class Seed::Unit < ActiveYaml::Base
  set_root_path 'config/active_hash'

  field :name
  field :slug
  field :race_id
  field :unit_class_id
end

