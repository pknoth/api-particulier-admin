json.extract! manager, :id, :name, :password_digest, :created_at, :updated_at
json.url manager_url(manager, format: :json)
