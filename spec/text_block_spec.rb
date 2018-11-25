require 'adaptive_cards'

describe AdaptiveCards::TextBlock do
  context 'basic text block hash format' do
    subject(:basic_text_block) { AdaptiveCards::TextBlock.new('Hello world!').to_h }

    it 'generates a valid TextBlock' do
      expect(basic_text_block[:type]).to eq('TextBlock')
      expect(basic_text_block[:text]).to eq('Hello world!')
    end
    
    it 'declares no options by default' do
      expect(basic_text_block.key?(:color)).to be false
      expect(basic_text_block.key?('isSubtle')).to be false
      expect(basic_text_block.key?('maxLines')).to be false
      expect(basic_text_block.key?(:weight)).to be false
      expect(basic_text_block.key?(:separator)).to be false
    end
  end
end
