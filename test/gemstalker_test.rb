require File.dirname(__FILE__) + '/test_helper'

class GemstalkerTest < Test::Unit::TestCase

  context "a gem that has not been built" do
    setup do
      @stalker = GemStalker.new(:name => 'technicalpickles-jeweler', :version => '0.7.3')
    end

    should "not be built yet" do
      assert ! @stalker.built?
    end

    should "not be in specfile yet" do
      assert ! @stalker.in_specfile?
    end
  end

  context "a gem that has been built and is available" do
    setup do
      @stalker = GemStalker.new(:name => 'technicalpickles-jeweler', :version => '0.7.2')
    end

    should "be built" do
      assert @stalker.built?
    end

    should "be in specfile" do
      assert @stalker.in_specfile?
    end
  end
end
