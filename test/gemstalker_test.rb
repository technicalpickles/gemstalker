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

    should "be a gem" do
      assert @stalker.gem?
    end    
  end

  context "a stalker, without username and repository" do
    setup do
      @stalker = GemStalker.new(:version => '0.8.1')
    end

    should "determine username from git remote" do
      assert_equal 'technicalpickles', @stalker.username
    end

    should "determine repository from git remote" do
      assert_equal 'gemstalker', @stalker.repository
    end

  end
  
  context "a stalker for something not marked as a gem" do
    setup do
      @stalker = GemStalker.new(:username => 'technicalpickles', :repository => 'bostonrb')
    end

    should "not be a gem" do
      assert ! @stalker.gem?
    end    
  end
end
