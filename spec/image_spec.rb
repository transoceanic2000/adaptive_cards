require 'adaptive_cards'

describe AdaptiveCards::Image do
  context 'basic image hash format' do
    subject(:basic_image) { AdaptiveCards::Image.new('https://example.com/image.png').to_h }

    it 'generates a valid Image' do
      expect(basic_image[:type]).to eq('Image')
      expect(basic_image[:url]).to eq('https://example.com/image.png')
    end
    
    it 'declares no options by default' do
      expect(basic_image.key?('altText')).to be false
      expect(basic_image.key?('horizontalAlignment')).to be false
      expect(basic_image.key?('id')).to be false
      expect(basic_image.key?('selectAction')).to be false
      expect(basic_image.key?('separator')).to be false
      expect(basic_image.key?('spacing')).to be false
      expect(basic_image.key?('size')).to be false
      expect(basic_image.key?('style')).to be false
    end
  end
  
  context 'accepts appropriate options' do
    subject(:basic_image) { AdaptiveCards::Image.new('https://example.com/image.png') }
    
    it 'accepts a select action' do
      basic_image.select_action = AdaptiveCards::Action::OpenUrl.new('https://example.com')
      expect(basic_image.select_action).to be_an_instance_of(AdaptiveCards::Action::OpenUrl)

      hash = basic_image.to_h['selectAction']
      expect(hash[:type]).to eq 'Action.OpenUrl'
      expect(hash[:url]).to eq 'https://example.com'
    end
    
    it 'accepts id value' do
      image_with_id = AdaptiveCards::Image.new('https://example.com/photo.jpg', id: '0x1234567890').to_h
      
      expect(image_with_id[:type]).to eq 'Image'
      expect(image_with_id[:url]).to eq 'https://example.com/photo.jpg'
      expect(image_with_id['id']).to eq '0x1234567890'
    end
    
    it "won't accept a non-string as an id value" do
      expect { basic_image.id = 42 }.to raise_error(AdaptiveCards::NotSupportedError)
    end
    
    it "won't accept show card action as the select action" do
      ac = AdaptiveCards::AdaptiveCard.new
      expect { basic_image.select_action = AdaptiveCards::Action::ShowCard.new(ac) }.to raise_error(AdaptiveCards::NotSupportedError)
    end
    
    it 'converts ruby symbol option values to camel-case options' do
      basic_image.spacing = :extra_large
      
      hash = basic_image.to_h
      expect(hash['spacing']).to eq 'extraLarge'
    end
    
    it 'accepts image-specific options' do
      basic_image.style = :person
      basic_image.horizontal_alignment = :right
      basic_image.alt_text = 'An image'
      
      hash = basic_image.to_h
      
      expect(hash['style']).to eq 'person'
      expect(hash['horizontalAlignment']).to eq 'right'
      expect(hash['altText']).to eq 'An image'
    end
  end
end
