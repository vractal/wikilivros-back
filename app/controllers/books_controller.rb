class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.send(:cover_file).attach(io: open_file(@book.cover), filename: 'cover')
    @book.send(:book_file).attach(io: open_file(@book.file), filename: 'file')
    @book.cover = url_for(@book.cover_file)
    @book.file =  url_for(@book.book_file)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :cover, :description, :author, :file)
    end

    # What is the proper way of accessing instance attr programaticaly?
    def attach_file(book, field,field_name)
      book.send(field_name).attach(io: open_file(book[field]), filename: field)
      url_for(book[field_name])
    end

    def open_file(encoded_file)
      filename =
      Rails.root.join(
        'tmp',
        "#{rand(36**30).to_s(36)}.#{file_extension(encoded_file)}"
      )
      File.open(filename, 'wb') do |f|
        f.write Base64.decode64(encoded_file.split(',')[1])
      end
    File.open(filename)
  end

  def file_extension(encoded_file)
    encoded_file.split(';').first.split('/').last
  end
end
