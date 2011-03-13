require "rubygems"
require 'httpclient'
require 'json'

class WordSearch < ActiveRecord::Base

  def get_yahoo_data(search_word)
    bbauth = "Hvr61tnV34EPeRiijXPssjA2Tf23LysUC0hb3Jqne80rVOVfMbw8KHTQp2aG5EOj"
    url = "http://answers.yahooapis.com/AnswersService/V1/getByCategory"

    session = HTTPClient.new()
    request = session.get(url,{:appid => bbauth, :category_name => "Health%3E#{search_word}", :results => 1})

    inforegexp = Regexp.new("<Content>([.\\w\\W]*)")
    searchdata = inforegexp.match(request.content)

    data = $1
    inforegexp = Regexp.new("([.\\w\\W]*)</Content>")
    searchdata = inforegexp.match(data)
    data = $1

    data
  end

  def WordSearch.find_using(keyword)

    db_entry = WordSearch.find_by_keyword(keyword)
    if db_entry == nil then
      db_entry = WordSearch.create_new_index(keyword)  # create a new index
    else
      db_entry.check_access_rate() if db_entry != nil # create a new index if the access rate has increased
    end
    db_entry

  end

  def WordSearch.create_new_index(keyword)
    newentry = WordSearch.new(:keyword => keyword)
    newentry.save
    newentry.update_entry()
    newentry

  end
  def check_access_rate()

    # To DO --- This is failing
    # The idea is that if a user starts to hit a site alot maybe they
    # know that there is an update required
    # Also if it is popular this is a crude way of weighting the
    # "Freshness"

    hittime = Time.now()
    self.search_hitcount_per_ten_mins = self.search_hitcount_per_ten_mins + 1
    self.search_hitcount_per_ten_mins = 0 if (hittime.min % 10) == 0
    if(self.search_hitcount_per_ten_mins > 100)
          update_entry()
    end
      #look for updated entry
  end

  def update_entry()
    self.results_yahoo = get_yahoo_data(self.keyword)
    self.results_twitter = get_twitter_data(self.keyword)
    self.google_results = get_google_data(self.keyword)
    self.search_hitcount_per_ten_mins = 0
    self.updated_at = Time.now
    self.save
  end

  def get_twitter_data(search_word)
    retval = nil
    begin
      url = "http://search.twitter.com/search.json"
      session = HTTPClient.new()
      request = session.get("#{url}",:q=> "@#{search_word}",:rpp => 3)
      data=JSON.parse(request.content)
      retval = ""
      count = 1
      data["results"].each { |res|
        retval = retval + "(Latest Post #{count}) #{res["text"]} "
        count = count + 1
      }
      retval
    rescue
      retval
    end

  end

  def get_google_data(search_word)
    url = "https://www.googleapis.com/customsearch/v1"
    googlekey = "AIzaSyCkVWzq_EBp6pLC55U6Yj7aoO8Efjar3g4"
    cxid = "017576662512468239146:omuauf_lfve"
    session = HTTPClient.new()
    request = session.get(url,:key => googlekey, :cx => cxid, :q=> search_word)

    data=JSON.parse(request.content)

    # TO DO -- Maybe spawn in a seperate thread/process
    add_google_data_to_key_word_search(data["items"][0]["snippet"],search_word)

    data["items"][0]["snippet"]
  end

  def add_google_data_to_key_word_search(data,search_word)
    keywords = data.split(" ")
    keywords.each{ |word|
      Words.add_words(word)
      DistinctWordhits.update_wordhits(word,search_word)
    }
  end
end
