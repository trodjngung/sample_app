require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  #check signin page kiem tra duong dan co duoc khong
  #khai bao duong dan trong routes.rb, cac ham trong controller
  describe "Signin page" do
  	before { visit signin_path }

  	it { should have_content('Sign in') }
  	it { should have_title('Sign in') }
  end

  #kiem tra dang nhap
  describe "Signin" do
  	before { visit signin_path }

  	#kiem tra dang nhap ko dung va dua ra thong bao

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    #kiem tra dang nhap dung
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        
        it { should have_link('Sign in') }
      end
    end

  end
end #end
