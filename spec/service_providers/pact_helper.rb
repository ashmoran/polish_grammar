require 'pact/consumer/rspec'

Pact.service_consumer "Polish Grammar Web" do
  has_pact_with "Polish Grammar API" do
    mock_service :polish_grammar_api do
      port 2401
    end
  end
end