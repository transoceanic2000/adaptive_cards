require 'adaptive_cards'

describe AdaptiveCards::AdaptiveCard do
  context "when empty" do
    subject(:empty_card_hash) { AdaptiveCards::AdaptiveCard.new.to_h }

    it "generates a v1.0 Adaptive Card" do
      expect(empty_card_hash['$schema']).to eq("http://adaptivecards.io/schemas/adaptive-card.json")
      expect(empty_card_hash[:type]).to eq('AdaptiveCard')
      expect(empty_card_hash[:version]).to eq('1.0')
    end
    
    it "has no body or action lists" do
      expect(empty_card_hash.key?(:body)).to be false
      expect(empty_card_hash.key?(:actions)).to be false
    end
    
    it "declares no options by default" do
      expect(empty_card_hash.key?('selectAction')).to be false
      expect(empty_card_hash.key?('fallbackText')).to be false
      expect(empty_card_hash.key?('backgroundImage')).to be false
      expect(empty_card_hash.key?(:speak)).to be false
      expect(empty_card_hash.key?(:lang)).to be false
    end
  end
  
  context "adding items" do
    subject(:card) { AdaptiveCards::AdaptiveCard.new }
    
    it "adds normal elements to the body" do
      card.add(AdaptiveCards::TextBlock.new('Hello world!'))

      expect(card.body.length).to eq 1
      expect(card.actions).to be_empty
    end
    
    it "adds actions to the action list" do
      card.add(AdaptiveCards::Action::OpenUrl.new('https://example.com/some_page.html'))
      
      expect(card.body).to be_empty
      expect(card.actions.length).to eq 1
    end
    
    it "can accept a chain of additions" do
      card.add(AdaptiveCards::TextBlock.new('Hello out there!'))
          .add(AdaptiveCards::TextBlock.new("I'm an adaptive card."))
          .add(AdaptiveCards::TextBlock.new('How are you?'))
          .add(AdaptiveCards::Action::OpenUrl.new('https://example.com/okay', title: "I'm okay thanks"))
      
      expect(card.body.length).to eq 3
      expect(card.actions.length).to eq 1
    end
    
    it "will accept plain text to create a text block" do
      card.add('Hello world, can you see me?')
      
      expect(card.body.length).to eq 1
      expect(card.body.first).to be_an_instance_of(AdaptiveCards::TextBlock)
      expect(card.body.first.text).to eq('Hello world, can you see me?')
    end
    
    it "won't accept non-card elements other than string" do
      expect { card.add(42) }.to raise_error(AdaptiveCards::InvalidElementError)
    end
  end
end
