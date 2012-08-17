require 'minitest/spec'
require 'minitest/autorun'
require 'hashie'
require 'mocha'
require_relative './xyz_service'
require 'date'

describe XYZService do

  describe "one situation" do
    before do
      messages = {
        :publish_on => Date.new(2012, 3, 14),
        :xyz_category_prefix => 'abc',
        :kind => 'unicorn',
        :personal? => false,
        :id => 1337,
        :title => 'magic & superglue'
      }
      target = Hashie::Mash.new messages

      XYZService.expects(:rand).with(10000).returns(4321)
      Digest::SHA1.expects(:hexdigest).with('4321').returns('abcdefghijklmnop')
      
      @subject = XYZService.xyz_filename(target)
    end

    it 'works' do
      @subject.must_equal '14abcunicorn_1337_abcdefgh_magicsuper.jpg'
    end
  end

  describe "another situation" do
    before do
      messages = {
        :publish_on => Date.new(2013, 7, 31),
        :xyz_category_prefix => 'get',
        :kind => 'applesauce',
        :personal? => true,
        :age => 1234567890,
        :id => 6512,
        :title => 'NOW IS THE TIME FOR ALL GOOD MEN'
      }
      target = Hashie::Mash.new messages

      XYZService.expects(:rand).with(10000).returns(7423)
      Digest::SHA1.expects(:hexdigest).with('7423').returns('rocksteady')
      
      @subject = XYZService.xyz_filename(target)
    end

    it 'works' do
      @subject.must_equal '31getapplesauce_1234567890_6512_rockstea_nowistheti.jpg'
    end
  end

end
