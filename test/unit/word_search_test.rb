require 'test_helper'

class WordSearchTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def name

  end

  test "find existing entry" do
    searchresult = WordSearch.find_by_keyword("Testword")
    assert_equal("Yahoo Some data to see",searchresult.results_yahoo)
    assert_equal("Twitter Some data to see",searchresult.results_twitter)
  end

  test "find a non existing entry" do
    searchresult = WordSearch.find_by_keyword("NewWord")
    assert_equal(searchresult,nil)
    WordSearch.getresults("NewWord")
    searchresult = WordSearch.find_by_keyword("NewWord")
    assert_not_equal(searchresult,nil)
  end

  test "find an existing entry and ensure update time is not changed" do
    searchresult = WordSearch.find_by_keyword("Testword")
    timefound = searchresult.updated_at
    searchresult2 = WordSearch.find_by_keyword("Testword")
    timefound2 = searchresult2.updated_at
    assert_equal(searchresult,searchresult2)
  end

  test "hit 200 times and verify the link is updated" do
    searchresult = WordSearch.find_using("Testword")
    timefound = searchresult.updated_at
    searchresult2 = WordSearch.find_using("Testword")
    timefound2 = searchresult2.updated_at
    assert_equal(searchresult,searchresult2)
    searchresult3 = nil
    200.times { searchresult3 = WordSearch.find_using("Testword")}
    assert_not_equal(searchresult,searchresult3)
  end

  test "check twitter search" do
    singleword = word_searches(:one)
    assert_not_equal(singleword,nil)
    twitterdata = singleword.get_twitter_data("radio")
    assert_not_nil(twitterdata)
  end

  test "check yahoo search" do
    singleword = word_searches(:one)
    assert_not_equal(singleword,nil)
    yahoodata = singleword.get_yahoo_data("Heart%20Disease")
    assert_not_nil(yahoodata)
  end

  test "check google search" do
    singleword = word_searches(:one)
    assert_not_equal(singleword,nil)
    googledata = singleword.get_google_data("bananas")
    assert_not_nil(googledata)
  end
end
