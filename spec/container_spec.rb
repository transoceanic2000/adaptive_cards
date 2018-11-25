require 'adaptive_cards'

describe AdaptiveCards::Container do
  context 'empty container hash format' do
    subject(:empty_container) { AdaptiveCards::Container.new.to_h }

    it 'generates a valid Container that contains an empty items array' do
      expect(empty_container[:type]).to eq('Container')
      expect(empty_container.key?(:items)).to be true
      expect(empty_container[:items]).to be_empty
    end
    
    it 'declares no options by default' do
      expect(empty_container.key?('selectAction')).to be false
      expect(empty_container.key?('isSubtle')).to be false
      expect(empty_container.key?('maxLines')).to be false
      expect(empty_container.key?('spacing')).to be false
      expect(empty_container.key?('separator')).to be false
    end
  end
  
  context 'adding items' do
    subject(:container) { AdaptiveCards::Container.new }
    
    it 'accepts other card elements' do
      container.add(AdaptiveCards::TextBlock.new('Hello world!'))
      container.add(AdaptiveCards::FactSet.new())
      
      expect(container.items.length).to eq(2)
    end
    
    it 'does not accept card actions' do
      expect { container.add(AdaptiveCards::Action::OpenUrl.new('https://example.com/')) }.to raise_error(AdaptiveCards::InvalidElementError)
    end
    
    it 'does not accept arbitrary items' do
      expect { container.add(42) }.to raise_error(AdaptiveCards::InvalidElementError)
    end
  end
end
