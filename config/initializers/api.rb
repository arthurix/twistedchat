API = YAML.load(
  ERB.new(
    File.read("#{Rails.root}/config/api.yml")
  ).result
)[Rails.env].with_indifferent_access
