require 'faraday'

class PracticeActivitySessionRepository
  include Lotus::Repository

  def find(session_id)
    connection = Faraday.new(url: ENV['POLGRAM_API_SERVER_URI']) do |faraday|
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    data = JSON.parse(connection.get(session_uri(session_id)).body)

    PracticeActivitySession.new(rekey_data(data))
  end

  private

  def session_uri(session_id)
    "/practice_activity_session/#{session_id}"
  end

  # dumb utility function for now
  def rekey_data(data)
    {
      id: data.fetch("id"),
      question: {
        lemma: data.fetch("question").fetch("lemma"),
        prompt: data.fetch("question").fetch("prompt")
      }
    }
  end
end
