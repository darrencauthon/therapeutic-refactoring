require 'minitest/spec'
require 'minitest/autorun'
require 'hashie'
require 'mocha'
require_relative './xyz_service'
require 'date'

describe XYZService do

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
