namespace :db do
  desc "Import legacy keys"
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

  desc "seed database"
  task seed: :environment do
    p Manager.where(
      name: 'octo',
      password: 'jesuissupersecret',
      password_confirmation: 'jesuissupersecret'
    ).first_or_create
  end
end
