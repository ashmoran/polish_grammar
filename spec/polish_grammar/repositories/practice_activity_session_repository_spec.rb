require 'spec_helper'
require 'pact/consumer/rspec'

RSpec.describe PracticeActivitySessionRepository, pact: true do
  subject(:repository) {
    PracticeActivitySessionRepository.new
  }

  describe "#find" do
    before do
      polish_grammar_api.given("a PracticeActivitySession exists").
        upon_receiving("a request for a PracticeActivitySession").
        with(method: :get, path: '/practice_activity_session/123').
        will_respond_with(
          status: 200,
          headers: {'Content-Type' => 'application/json'},
          body: {
            id: "123",
            question: {
              lemma: 'jeść', prompt: 'ja dzisiaj'
            }
          }
        )
    end

    describe "response" do
      it "returns a PracticeActivitySession" do
        expect(repository.find("123")).to eq(
          PracticeActivitySession.new(
            id: "123",
            question: {
              lemma: 'jeść', prompt: 'ja dzisiaj'
            }
          )
        )
      end

      it "contains the complete description" do
        expect(repository.find("123").question).to eq(
          { lemma: 'jeść', prompt: 'ja dzisiaj' }
        )
      end
    end
  end
end
