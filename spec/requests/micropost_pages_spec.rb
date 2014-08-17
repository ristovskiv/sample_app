require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do  
    before do
      FactoryGirl.create(:micropost, user: user)
      visit root_path 
    end

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
  end

  describe "pagination" do
    before do
      31.times{FactoryGirl.create(:micropost,user: user)}
    end
    after(:all){user.microposts.delete_all}

    before {visit root_path}

    it{should have_content("31 microposts")}

    it { should have_selector('div.pagination') }

    it "should list each micropost" do
      user.feed.paginate(page: 1).each do |micropost|
        expect(page).to have_selector("li",text: micropost.content)
      end
    end
  end

  describe "no delete links for microposts not created by the current user" do
    let(:wrong_user){FactoryGirl.create(:user)}
    let(:m1){FactoryGirl.create(:micropost,user: wrong_user)}
    before do
      visit root_path
    end

    it{should_not have_link("delete",href: micropost_path(m1))}
  end
end 