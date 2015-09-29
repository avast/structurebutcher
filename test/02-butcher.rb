require 'minitest/autorun'
require 'structbutcher'

class ParseTest < Minitest::Test
    def test_amputate
        butcher = StructButcher.new
        body = { "head" => 1, "trunk" => { "arms" => 2, "legs" => 2 } }
        part = butcher.amputate(body, "trunk.arms")
        assert_equal(part, 2)
    end

    def test_implantate
        butcher = StructButcher.new
        body = { "head" => 1, "trunk" => { "arms" => 2, "legs" => 2 } }
        butcher.implantate(body, "trunk.arms", 3)
        assert_equal(body["trunk"]["arms"], 3)
    end
end

