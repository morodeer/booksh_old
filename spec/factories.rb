# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    username "morodeer"
    email "morodeer@gmail.com"
    first_name "Юрий"
    last_name "Дынников"
    password "helloworld"
    password_confirmation "helloworld"
    city "Жуковский"
  end

  factory :book do
    name "Книга мертвых. Часть 1"
    author_names "С.Лукьяненко, А.Белянин"
    detail "Книга повествует ни о чем"
    isbn "123-123-123X"
    publish_year "2009"
  end

  factory :author do
    name "Борис Акунин"
    real_name "Григорий Чхартишвили"
    wiki_link "https://ru.wikipedia.org/wiki/%D0%91%D0%BE%D1%80%D0%B8%D1%81_%D0%90%D0%BA%D1%83%D0%BD%D0%B8%D0%BD"
  end

end
