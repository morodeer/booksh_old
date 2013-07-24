# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  remember_token  :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  city            :string(255)
#  geo_coordinates :string(255)
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  before {@user = User.new(username: "username", email: "morodeer@gmail.com",
                           first_name: "Юрий", last_name: "Дынников", city: "Жуковский",
                           password: "helloworld", password_confirmation: "helloworld"
  )}

  subject {@user}

  it {should respond_to(:username)}
  it {should respond_to(:email)}
  it {should respond_to(:first_name)}
  it {should respond_to(:last_name)}
  it {should respond_to(:city)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:remember_token)}
  it {should respond_to(:book_specimens)}

  it {should be_valid}

  describe "when first name is not present" do
    before {@user.first_name = " "}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before {@user.email = " "}
    it {should_not be_valid}
  end

  describe "when first_name is too long(31)" do
    before {@user.first_name = "a"*31}
    it {should_not be_valid}
  end

  describe "when last_name is too long(31)" do
    before {@user.last_name = "a"*31}
    it {should_not be_valid}
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end


  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it {should_not be_valid}
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token) {should_not be_blank}
  end

  describe "Having books" do
    let(:book) {FactoryGirl.create(:book)}
    before {@user.save}


    it "obtaining should create specimen" do
      expect {@user.obtain!(book)}.to change(@user.book_specimens, :count).by(1)
    end

    describe "specimen should have right ids" do
      before do
        @user.obtain!(book)
      end

      its(:book_specimens) {should include(BookSpecimen.find_by_book_id(book.id))}
      its(:book_specimens) {should include(BookSpecimen.find_by_owner_id(@user.id))}
    end
  end

end
