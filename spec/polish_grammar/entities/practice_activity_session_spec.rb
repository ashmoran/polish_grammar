require 'spec_helper'

RSpec.describe PracticeActivitySession do
  def default_args(modifications = { })
    {
      id: "123",
      question: {
        lemma: 'jeść', prompt: 'ja dzisiaj'
      }
    }.merge(modifications)
  end

  subject(:session) {
    described_class.new(
      id: "123",
      question: {
        lemma: 'jeść', prompt: 'ja dzisiaj'
      }
    )
  }

  describe "#==" do
    example "identical" do
      expect(session).to eq(
        described_class.new(default_args)
      )
    end

    example "different id" do
      expect(session).to_not eq(
        described_class.new(default_args(id: "666"))
      )
    end

    # equal due to Lotus's entity matching… correct behaviour
    # from the framework, but maybe not what we want
    example "same id different contents" do
      expect(session).to eq(
        described_class.new(
          default_args(question: { lemma: 'wrong', prompt: 'also wrong' })
        )
      )
    end
  end
end
