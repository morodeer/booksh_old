# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "UserPages" do

  let(:user) {FactoryGirl.create(:user)}

  subject { page }

  describe "as unsigned user" do

    describe "get user_path" do
      before {visit user_path(user)}
      specify {response.should redirect_to(signin_path)}
    end

    describe "try creating a book" do
      before { visit new_book_specimen_path }
      specify {response.should redirect_to(signin_path)}
    end

  end

end
