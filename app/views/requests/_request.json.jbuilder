json.extract! request, :id, :applicant, :relation, :gaurdian, :created_at, :updated_at
json.url request_url(request, format: :json)
