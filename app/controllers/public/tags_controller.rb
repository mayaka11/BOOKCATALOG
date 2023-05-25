class Public::TagsController < ApplicationController

  def search_book
    @model = Book #search機能とは関係なし
    @word = params[:word]
    @books = Book.where("tag LIKE?","%#{@word}%")
    render "searches/result"
  end
end