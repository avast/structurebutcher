require 'minitest/autorun'
require 'structbutcher'

class ParseTest < Minitest::Test
    def test_json
        parser = StructButcher::Parser.new
        loaded = parser.load_json('test/test.json')
        assert_equal(loaded[0], 'test')
    end
end


