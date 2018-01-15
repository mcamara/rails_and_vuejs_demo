module ApiHelper
  def json_response
    JSON.parse(response.body)
  rescue StandardError
    nil
  end
end
