require 'adaptive_cards'

describe AdaptiveCards::Action::OpenUrl do
  context 'basic open URL action' do
    subject(:open_url_action) { AdaptiveCards::Action::OpenUrl.new('https://example.com/').to_h }

    it 'generates a valid OpenUrl action' do
      expect(open_url_action[:type]).to eq('Action.OpenUrl')
      expect(open_url_action[:url]).to eq('https://example.com/')
    end

    it 'declares no options by default' do
      expect(open_url_action.key?(:color)).to be false
      expect(open_url_action.key?('isSubtle')).to be false
      expect(open_url_action.key?('maxLines')).to be false
      expect(open_url_action.key?(:title)).to be false
    end
  end

  context 'action accepts options' do
    it 'accepts options when initialized' do
      action = AdaptiveCards::Action::OpenUrl.new('https://economist.com/', title: 'The Economist')
      hash = action.to_h
      
      expect(hash[:url]).to eq('https://economist.com/')
      expect(hash['title']).to eq('The Economist')
    end

    it 'accepts options after initialization' do
      action = AdaptiveCards::Action::OpenUrl.new('https://ft.com/')
      action.title = 'The Financial Times'
      hash = action.to_h

      expect(hash[:url]).to eq('https://ft.com/')
      expect(hash['title']).to eq('The Financial Times')
    end
  end
end
