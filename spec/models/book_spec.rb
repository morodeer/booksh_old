# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Book do

  before {@book = Book.new(name: 'Book', author_names: 'Author_one, Author_two',
                          isbn: '123-123-345X', publish_year: '2009')}

  subject {@book}

  it {should respond_to(:name)}
  it {should respond_to(:author_names)}
  it {should respond_to(:detail)}
  it {should respond_to(:isbn)}
  it {should respond_to(:clean_isbn)}
  it {should respond_to(:publish_year)}

  it {should be_valid}

  describe "with empty name" do
    before {@book.name = ' '}
    it {should_not be_valid}
  end

  describe "with empty author names" do
    before {@book.author_names = ' '}
    it {should_not be_valid}
  end

    describe "it should have right isbn" do
      before {@book.save}
      its(:clean_isbn) {should== '123123345X'}
    end

  describe "Authors" do
    let(:author) {FactoryGirl.create(:author)}


    before {
      author.save
      @book.save
    }
    describe "Author's own!"    do
    it "should increment book's authors" do

      expect {author.own!(@book)}.to change(@book.authors, :count).by(1)
    end
    end

    describe "Author should be open for access" do
      before {author.own!(@book)}
      specify {@book.authors.first.real_name.should == "Григорий Чхартишвили"}
    end

    describe "reverse_author_book_relationship should have correct book_id" do
      before do
        @book.save
        author.own!(@book)
      end

      specify {@book.reverse_book_author_relationships.first.book_id.should == @book.id}
    end
  end


end
