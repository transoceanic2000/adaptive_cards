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
  
  context 'accepts appropriate options' do
    subject(:empty_set) { AdaptiveCards::ColumnSet.new }
    
    it 'accepts a select action' do
      empty_set.select_action = AdaptiveCards::Action::OpenUrl.new('https://example.com')
      expect(empty_set.select_action).to be_an_instance_of(AdaptiveCards::Action::OpenUrl)

      action_hash = empty_set.to_h['selectAction']
      expect(action_hash[:type]).to eq 'Action.OpenUrl'
      expect(action_hash[:url]).to eq 'https://example.com'
    end
    
    it 'accepts id value' do
      column_set_with_id = AdaptiveCards::ColumnSet.new(id: '0x1234ab').to_h
      
      expect(column_set_with_id[:type]).to eq 'ColumnSet'
      expect(column_set_with_id['id']).to eq '0x1234ab'
    end
    
    it "won't accept a non-string as an id value" do
      expect { empty_set.id = true }.to raise_error(AdaptiveCards::NotSupportedError)
    end
    
    it "won't accept show card action as the select action" do
      ac = AdaptiveCards::AdaptiveCard.new
      expect { empty_set.select_action = AdaptiveCards::Action::ShowCard.new( ac ) }.to raise_error(AdaptiveCards::NotSupportedError)
    end
    
    it 'converts ruby symbol option values to camel-case options' do
      empty_set.spacing = :extra_large
      
      hash = empty_set.to_h
      expect(hash['spacing']).to eq 'extraLarge'
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
      expect { set.add(AdaptiveCards::Container.new) }.to raise_error(AdaptiveCards::InvalidContentError)
      
      expect { set.add(AdaptiveCards::TextBlock.new('Hello world')) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
    
    it 'does not accept card actions' do
      expect { set.add(AdaptiveCards::Action::OpenUrl.new('https://example.com/')) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
    
    it 'does not accept arbitrary items' do
      expect { set.add(42) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
  end
end
