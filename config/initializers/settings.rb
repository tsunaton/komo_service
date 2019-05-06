class Settings < Settingslogic
  source Rails.root.join("config").join("application.yml")
  Settings.url % @working_hour.id
  namespace Rails.env
end
