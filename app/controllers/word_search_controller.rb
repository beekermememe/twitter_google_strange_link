class WordSearchController < ApplicationController
  def show
  end

  def new
  end

  def update
  end

  def delete
  end

  def getresults
    search_word=params[:wordtofind]

    render :inline => "<xml><error>Please enter a word</error><search1data></search1data><search2data></search2data></xml>" if (search_word == nil) || (search_word == "")
    return if  (search_word == nil) || (search_word == "")


    #make sure there is only one work
    checkit = search_word.split(" ")

    render :inline => "<xml><error>Only enter one word</error><search1data></search1data><search2data></search2data></xml>" if checkit.length > 1
    return if checkit.length > 1


    results = WordSearch.find_using(search_word)
    render :inline => "<xml><error></error><search1data>#{results.google_results}</search1data><search2data>#{results.results_twitter}</search2data></xml>"

  end

  def refresh
  end

end
