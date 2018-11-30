require 'adaptive_cards'

describe AdaptiveCards::ImageSet do
  context 'empty image set hash format' do
    subject(:empty_set) { AdaptiveCards::ImageSet.new.to_h }

    it 'generates a valid ImageSet with no images listed' do
      expect(empty_set[:type]).to eq('ImageSet')
      expect(empty_set[:images]).to be_empty
    end
    
    it 'declares no options by default' do
      expect(empty_set.key?('id')).to be false
      expect(empty_set.key?('imageSize')).to be false
      expect(empty_set.key?('spacing')).to be false
      expect(empty_set.key?('separator')).to be false
    end
  end
  
  context 'accepts appropriate options' do
    subject(:empty_set) { AdaptiveCards::ImageSet.new }
    
    it 'accepts an image size' do
      empty_set.image_size = :stretch
      hash = empty_set.to_h
      
      expect(hash['imageSize']).to eq 'stretch'
    end
    
    it 'accepts id value' do
      empty_set.id = '0x12345'
      hash = empty_set.to_h
      
      expect(hash[:type]).to eq 'ImageSet'
      expect(hash['id']).to eq '0x12345'
    end
    
    it "won't accept an invalid image size value" do
      expect { empty_set.image_size = :super_huge }.to raise_error(AdaptiveCards::NotSupportedError)
    end
  end
  
  context 'adding items' do
    subject(:set) { AdaptiveCards::ImageSet.new }
    
    it 'accepts columns' do
      set.add(AdaptiveCards::Image.new('https://example.com/diagram.png'))
      set.add(AdaptiveCards::Image.new('https://example.com/photo.jpg', image_size: :small))
      
      expect(set.images.length).to eq(2)
      expect(set.image_size).to be_nil
      expect(set.images[1].image_size).to eq('small')
    end
    
    it 'does not accept other card items' do
      expect { set.add(AdaptiveCards::Column.new) }.to raise_error(AdaptiveCards::InvalidContentError)
      
      expect { set.add(AdaptiveCards::TextBlock.new('Hello world')) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
    
    it 'does not accept card actions' do
      expect { set.add(AdaptiveCards::Action::OpenUrl.new('https://example.com/')) }.to raise_error(AdaptiveCards::InvalidContentError)
    end
    
    it 'does not accept arbitrary items' do
      expect { set.add('hello out there!') }.to raise_error(AdaptiveCards::InvalidContentError)
    end
  end
end
