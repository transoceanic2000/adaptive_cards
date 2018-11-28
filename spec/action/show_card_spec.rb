require 'adaptive_cards'

describe AdaptiveCards::Action::ShowCard do
  context 'basic show an empty card' do
    subject(:open_url_action) { AdaptiveCards::Action::ShowCard.new(AdaptiveCards::AdaptiveCard.new).to_h }

    it 'generates a valid ShowCard action' do
      expect(open_url_action[:type]).to eq('Action.ShowCard')
      expect(open_url_action[:card][:type]).to eq('AdaptiveCard')
    end

    it 'declares no options by default' do
      expect(open_url_action.key?('title')).to be false
    end
  end

  context 'action accepts options' do
    it 'accepts options when initialized' do
      action = AdaptiveCards::Action::ShowCard.new(AdaptiveCards::AdaptiveCard.new, title: 'An empty card')
      hash = action.to_h
      
      expect(hash[:type]).to eq('Action.ShowCard')
      expect(hash[:card][:type]).to eq('AdaptiveCard')
      expect(hash['title']).to eq('An empty card')
    end

    it 'accepts options after initialization' do
      action = AdaptiveCards::Action::ShowCard.new(AdaptiveCards::AdaptiveCard.new)
      action.title = 'Another empty card'
      hash = action.to_h

      expect(hash[:type]).to eq('Action.ShowCard')
      expect(hash[:card][:type]).to eq('AdaptiveCard')
      expect(hash['title']).to eq('Another empty card')
    end
  end
end
