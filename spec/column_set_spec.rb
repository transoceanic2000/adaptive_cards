require 'adaptive_cards'

describe AdaptiveCards::ColumnSet do
  context 'empty column set hash format' do
    subject(:empty_set) { AdaptiveCards::ColumnSet.new.to_h }

    it 'generates a valid ColumnSet with no columns defined' do
      expect(empty_set[:type]).to eq('ColumnSet')
      expect(empty_set.key?(:columns)).to be false
    end
    
    it 'declares no options by default' do
      expect(empty_set.key?('selectAction')).to be false
      expect(empty_set.key?('id')).to be false
      expect(empty_set.key?('spacing')).to be false
      expect(empty_set.key?('separator')).to be false
    end
  end
  
  context 'adding items' do
    subject(:set) { AdaptiveCards::ColumnSet.new }
    
    it 'accepts columns' do
      set.add(AdaptiveCards::Column.new)
      set.add(AdaptiveCards::Column.new)
      
      expect(set.columns.length).to eq(2)
    end
    
    it 'does not accept other card items' do
      expect { set.add(AdaptiveCards::Container.new) }.to raise_error(AdaptiveCards::InvalidElementError)
      
      expect { set.add(AdaptiveCards::TextBlock.new('Hello world')) }.to raise_error(AdaptiveCards::InvalidElementError)
    end
    
    it 'does not accept card actions' do
      expect { set.add(AdaptiveCards::Action::OpenUrl.new('https://example.com/')) }.to raise_error(AdaptiveCards::InvalidElementError)
    end
    
    it 'does not accept arbitrary items' do
      expect { set.add(42) }.to raise_error(AdaptiveCards::InvalidElementError)
    end
  end
end
