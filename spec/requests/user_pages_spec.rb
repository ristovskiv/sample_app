require 'spec_helper'

describe "UserPages" do

  subject { page }  

  shared_examples_for "all user pages" do
      it {should have_selector('h1',text:heading)}
      it {should have_title(full_title(page_title))}
  end

  describe "signup page" do

    before do
      visit signup_path
    end

    let(:heading) {'Sign up'}
    let(:page_title) {'Sign up'}

    it_should_behave_like 'all user pages'
  end

  describe "profile page" do
    let(:user){FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit){"Create my account"}

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example user"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect {click_button submit}.to change(User, :count).by(1) 
      end

      describe "after saving user" do
        let(:user){User.find_by(email: "user@example.com")}

        it {should have_link("Sign out")}
        it {should have_title(user.name)}
        it {should have_selector("div.alert.alert-success", text:"Welcome")}
      end 

    end
  end

  describe "after submission error" do
    before do
      visit signup_path
      click_button "Create my account"
    end

    it {should have_title("Sign up")}
    it {should have_content("error")}
  end
end

