require 'dotenv'
Dotenv.load

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
    # raise ENV.inspect
    return unless ENV['SEED_USER'].present? && ENV['SEED_PASSWORD']
    p Manager.where(
      name: ENV['SEED_USER'],
      password: ENV['SEED_PASSWORD'],
      password_confirmation: ENV['SEED_PASSWORD']
    ).first_or_create
  end

  desc "hash legacy token"
  task hash_legacy_tokens: :environment do
    Tasks::HashLegacyTokens.new(Token.all).duplicate_old_tokens
  end
end
