require 'spec_helper'

describe "Static Pages" do

  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading)}
    it { should have_title(full_title(page_title))}
  end

  describe "Home page" do
    
    before do 
      visit root_path
      click_link "Home"
    end

    let(:heading) {'Sample App'}
    let(:page_title) {''}
    
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home')}     
  end

	describe 'Help page' do
    
    before do 
      visit help_path
      click_link "Help"
    end

    let(:heading) {'Help'}
    let(:page_title) {'Help'}
    
    it_should_behave_like "all static pages"
	end

	describe 'About page' do

    before do
      visit about_path 
      click_link "About"
    end

    let(:heading) {'About Us'}
    let(:page_title) {'About'}
    
    it_should_behave_like "all static pages"
	end
	
	describe 'Contact page' do

    before do
      visit contact_path 
      click_link "Contact"
    end

    let(:heading) {"Contact"}
    let(:page_title) {"Contact"}
    
    it_should_behave_like "all static pages"
		end
end
