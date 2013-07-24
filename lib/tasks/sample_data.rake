# -*- encoding : utf-8 -*-
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    make_users
    make_books
    make_authors

    make_book_specimens
    make_book_author_relationships

  end

  def make_users

    User.create!(
        first_name:"Юрий",
        last_name:"Дынников",
        city:"Жуковский",
        username: "Morodeer",
        email: "morodeer@gmail.com",
        password: "qwerty",
        password_confirmation: "qwerty"
    )

    20.times do |n|
      username = Faker::Internet.user_name
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      city = Faker::Address.city
      email = Faker::Internet.email
      password = "helloworld"
      password_confirmation = "helloworld"

      User.create!( username: username,
                    first_name:first_name,
                   last_name:last_name,
                   city:city,
                   email:email,
                   password:password,
                   password_confirmation:password_confirmation
      )
    end
  end

  def make_books
    authors = ["Джордж Мартин", "Борис Акунин", "Эрика Леонард Джеймс", "Нора Робертс", "Стивен Кинг", "Эрих Мария Ремарк", "Агата Кристи", "Эльчин Сафарли", "Сесилия Ахерн", "Джеймс Роллинс", "Джоанна Линдсей", "Джудит Макнот", "Вадим Зеланд"]
    31.times do |n|

        title = Faker::Lorem.sentence(3)
        detail = Faker::Lorem.paragraph(20)
        isbn = (0..9).to_a.shuffle().join
        author_names = authors[ rand(authors.count) ]
        publish_year = '2009'
        Book.create!(title: title,
                     detail: detail,
                     isbn: isbn,
                     author_names: author_names,
                     publish_year: publish_year
        )
      end
  end

  def make_authors
    authors = ["Джордж Мартин", "Борис Акунин", "Эрика Леонард Джеймс", "Нора Робертс", "Стивен Кинг", "Эрих Мария Ремарк", "Агата Кристи", "Эльчин Сафарли", "Сесилия Ахерн", "Джеймс Роллинс", "Джоанна Линдсей", "Джудит Макнот", "Вадим Зеланд"]
    authors.count.times do |n|
        name = authors[n]
        real_name = Faker::Name.name
        wiki_link = Faker::Internet.url
        Author.create!(name:name,
                       real_name:real_name,
                       wiki_link:wiki_link
        )
    end

  end

  def make_book_specimens
    users = User.all
    books_count = Book.count
    users.each { |user|
      5.times do |n|
        user.obtain!(Book.find_by_id(1+ rand(books_count-1)))
      end
    }
  end

  def make_book_author_relationships
    books = Book.all
    authors_count = Author.count
    books.each { |book|
      2.times do |n|
        Author.find_by_id(1+ rand(authors_count - 1)).own!(book)
      end
    }
  end
end