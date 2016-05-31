json.array!(@projects) do |project|
  json.extract! project, :id, :name, :submission_date, :description, :user_id
  json.url project_url(project, format: :json)
end
