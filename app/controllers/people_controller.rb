class PeopleController < ApplicationController
  def index
  end

  def autocomplete_person_name
    render :json => Person.search(params['term'])
  end

  def autocomplete_person_name_sql
    render :json => Person.searchsql(params['term'])
  end
end