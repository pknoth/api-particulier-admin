namespace :db do
  desc "TODO"
  task import_keys: :environment do
    old_keys = JSON.parse(
      File.read('/etc/api-particulier/tokens/tokens.json')
    )
    old_keys.map do |k, v|
      {
        id: k,
        name: v['name'],
        email: v['mail']
      }
    end.each do |token|
      Token.create(token)
    end
  end
end
