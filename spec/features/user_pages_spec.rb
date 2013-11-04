# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "UserPages" do


  subject { page }

  describe "signing up" do
    before do
      visit signup_path
      fill_in "Username", with: 'Morodeer'
      fill_in "Password", with: 'qwerty'
      fill_in "Confirm password", with: 'qwerty'
      fill_in "Email", with: 'morodeer@gmail.com'
      fill_in "First name", with: 'Yuriy'
      fill_in "Last name", with: 'Dynnikov'

      click_button 'Submit'

    end
    it { should have_selector('h1', text: 'Yuriy Dynnikov (Это вы)') }
  end

  describe "as unsigned user" do

    let(:user) { FactoryGirl.create(:user) }


    describe "get user_path" do
      before { visit user_path(user) }
      specify { current_path.should == signin_path }
    end

    describe "try creating a book" do
      before { visit new_book_specimen_path }
      specify { current_path.should == signin_path }
    end

    describe "home page" do
      before { visit root_path }

      describe "it should have proper links" do

        it {
          should have_link('Войти', signin_path)
          should_not have_link('Уйти', signout_path)
          should_not have_link('Люди', users_path)
          should_not have_link('Друзья', friends_path)
        }

      end
    end

  end

  describe "signing in" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    specify { current_path.should == root_path }
  end

  describe "as signed_in user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }


    describe "home page" do
      before { visit root_path }

      it {
        should have_selector('h1', user.full_name)
        should have_link('Уйти', signout_path)
        should have_link('Люди', users_path)
        should have_link('Друзья', friends_path)
      }


      describe "books_block" do
        let(:book) { FactoryGirl.create(:book) }
        before do
          obtain book
        end


        describe "book_specimen page" do
          it { should have_selector('#owner_info', text: "#{user.full_name} (Это вы)") }

        end


        describe "user_page" do
          before { visit root_path }


          describe "having right tags in book_shelve" do
            it {
              should have_selector('div.book_wrapper')
              should have_selector('div.title', book.title)
              should have_selector('div.author', book.author_names)
            }

          end

        end


      end
    end

  end

end
