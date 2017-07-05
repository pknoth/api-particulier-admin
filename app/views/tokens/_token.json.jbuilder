json.extract! token, :id, :_id, :name, :email, :created_at, :updated_at
json.url token_url(token, format: :json)
