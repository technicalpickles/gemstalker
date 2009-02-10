require File.dirname(__FILE__) + '/test_helper'

class GemstalkerTest < Test::Unit::TestCase

  context "a stalker for a specific version of a gem that has not been built" do
    setup do
      @stalker = GemStalker.new(:username => 'technicalpickles', :repository => 'jeweler', :version => '0.9.3')
    end

    should "not be built yet" do
      assert ! @stalker.built?
    end

    should "not be in specfile yet" do
      assert ! @stalker.in_specfile?
    end
  end

  context "a stalker for a specific version of a gem that has been built and is available" do
    setup do
      @stalker = GemStalker.new(:username => 'technicalpickles', :repository => 'jeweler', :version => '0.8.1')
    end

    should "be built" do
      assert @stalker.built?
    end

    should "be in specfile" do
      assert @stalker.in_specfile?
    end
  end

  context "a stalker without a specific version of a gem that has been built" do
    setup do
      @stalker = GemStalker.new(:username => 'technicalpickles', :repository => 'jeweler')
    end

    should "determine version" do
      assert_equal '0.8.1', @stalker.version
    end

    should "be built" do
      assert @stalker.built?
    end

    should "be in specfile" do
      assert @stalker.in_specfile?
    end
  end
end
