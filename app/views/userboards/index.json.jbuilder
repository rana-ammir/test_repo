json.array!(@userboards) do |userboard|
  json.extract! userboard, :id
  json.url userboard_url(userboard, format: :json)
end
