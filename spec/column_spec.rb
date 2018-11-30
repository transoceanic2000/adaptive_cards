require 'adaptive_cards'

describe AdaptiveCards::Column do
  context 'empty column hash format' do
    subject(:empty_column) { AdaptiveCards::Column.new.to_h }

    it 'generates a valid ColumnSet with empty item list' do
      expect(empty_column[:type]).to eq('Column')
      expect(empty_column.key?(:items)).to be true
      expect(empty_column[:items]).to be_empty
    end
    
    it 'declares no options by default' do
      expect(empty_column.key?('id')).to be false
      expect(empty_column.key?('selectAction')).to be false
      expect(empty_column.key?('separator')).to be false
      expect(empty_column.key?('spacing')).to be false
      expect(empty_column.key?('style')).to be false
      expect(empty_column.key?('width')).to be false
    end
  end
  
  context 'accepts appropriate options' do
    subject(:empty_column) { AdaptiveCards::Column.new }
    
    it 'accepts a select action' do
      empty_column.select_action = AdaptiveCards::Action::OpenUrl.new('https://example.com')
      expect(empty_column.select_action).to be_an_instance_of(AdaptiveCards::Action::OpenUrl)

      action_hash = empty_column.to_h['selectAction']
      expect(action_hash[:type]).to eq 'Action.OpenUrl'
      expect(action_hash[:url]).to eq 'https://example.com'
    end
    
    it 'accepts id value' do
      column_with_id = AdaptiveCards::Column.new(id: '0xabcdef').to_h
      
      expect(column_with_id[:type]).to eq 'Column'
      expect(column_with_id['id']).to eq '0xabcdef'
    end
    
    it "won't accept a non-string as an id value" do
      expect { empty_column.id = 42 }.to raise_error(AdaptiveCards::NotSupportedError)
    end
    
    it "won't accept show card action as the select action" do
      ac = AdaptiveCards::AdaptiveCard.new
      expect { empty_column.select_action = AdaptiveCards::Action::ShowCard.new(ac) }.to raise_error(AdaptiveCards::NotSupportedError)
    end
  end
  
  context 'adding items' do
    subject(:column) { AdaptiveCards::Column.new }
    
    it 'accepts block-level elements' do
      column.add(AdaptiveCards::Container.new)
      column.add(AdaptiveCards::TextBlock.new('Hello out there!'))
      
      expect(column.items.length).to eq(2)
    end
    
    it 'does not accept card actions' do
      expect { column.add(AdaptiveCards::Action::OpenUrl.new('https://example.com/')) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
    
    it 'does not accept arbitrary items' do
      expect { column.add(false) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
  end
end
