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
      expect(empty_card_hash.key?('speak')).to be false
      expect(empty_card_hash.key?('lang')).to be false
    end
  end
  
  context "accepts appropriate options" do
    subject(:empty_card) { AdaptiveCards::AdaptiveCard.new }
    
    it 'accepts a select action' do
      empty_card.select_action = AdaptiveCards::Action::OpenUrl.new('https://example.com')
      expect(empty_card.select_action).to be_an_instance_of(AdaptiveCards::Action::OpenUrl)

      action_hash = empty_card.to_h['selectAction']
      expect(action_hash[:type]).to eq 'Action.OpenUrl'
      expect(action_hash[:url]).to eq 'https://example.com'
    end
    
    it 'accepts fallback text' do
      card_hash = AdaptiveCards::AdaptiveCard.new(fallback_text: 'This is some fallback text').to_h
      
      expect(card_hash[:type]).to eq 'AdaptiveCard'
      expect(card_hash['fallbackText']).to eq 'This is some fallback text'
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
      expect { card.add(42) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
    
    it "accepts a complex set of components with different options" do
      card.add(AdaptiveCards::TextBlock.new('This is an introduction to this card', size: 'large', color: :accent))
          .add(AdaptiveCards::ColumnSet.new().add(AdaptiveCards::Column.new(width: 'auto'))
                                             .add(AdaptiveCards::Column.new(width: :stretch)))
          .add(AdaptiveCards::FactSet.new(separator: true).add('2^0', '1')
                                                          .add('2^1', '2')
                                                          .add('2^2', '4')
                                                          .add('2^3', '8'))
      
      expect(card.body.length).to eq 3
      expect(card.body[0]).to be_an_instance_of(AdaptiveCards::TextBlock)
      expect(card.body[1]).to be_an_instance_of(AdaptiveCards::ColumnSet)
      expect(card.body[2]).to be_an_instance_of(AdaptiveCards::FactSet)
    end
    
    it "enforces options in a complex set of components with different options" do
      expect { card.add(AdaptiveCards::TextBlock.new('This is an introduction to this card', size: 'large'))
                   .add(AdaptiveCards::ColumnSet.new().add(AdaptiveCards::Column.new(width: 'auto'))
                                                      .add(AdaptiveCards::Column.new(width: 'invalid-stretch'))) }.to raise_error(AdaptiveCards::NotSupportedError)
    end
  end
end
