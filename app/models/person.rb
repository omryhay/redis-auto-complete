class Person < ActiveRecord::Base
  after_save :load_into_soulmate

  def load_into_soulmate
    loader = Soulmate::Loader.new("person")
    loader.add("term" => name, "id" => id, "score" => rating_count)
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('person').matches_for_term(term, :limit => 50)
    matches.collect {|match| {"id" => match["id"], "label" => match["term"], "value" => match["term"] } }
  end

  def self.searchsql(term)
  	matches = self.find_by_sql("Select * from people where name like '#{term}%' order by rating_count limit 50")
  	matches.collect {|match| {"id" => match["id"], "label" => match["term"], "value" => match["name"] } }
  end
end