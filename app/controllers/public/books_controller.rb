class Public::BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to books_path
    else
      render :new
    end
  end

  def index
    @books = Book.all

    @tags = Tag.all
    @books = params[:name].present? ? Tag.find(params[:name]).books : Book.all
  end


  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end


  def edit
     @book = Book.find(params[:id])
  end


  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end



    private

  def book_params
    params.require(:book).permit(:tag, :memo, :title, :comment, :author, :publisher, tag_ids: [])
  end
end
