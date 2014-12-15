require "rails_helper"

RSpec.describe ControlsController, :type => :controller do
  describe "GET index" do

    let(:user) { 
    FactoryGirl.create(:user)  
    }

    let(:control) {
      FactoryGirl.create(:control)
    }
    context "logged in" do
      before :each do
        control.user_id = user.id
        sign_in :user, user
      end

      it "loads all controls into @controls" do
        get :index
        expect(assigns(:controls)).to eq([control])
      end

      it "assigns a new control to @control" do
        get :index
        expect(assigns(:control)).to be_a_new(Control)
      end

      it "renders the index template" do 
        get :index
        expect(response). to render_template("index")
      end

      it "stays in the controls page upon save" do
        post :create, control: { user_id: user.id, level: 120, period: "pre-breakfast", day: DateTime.now.strftime('%m/%d/%Y %I:%M %p') }
        expect(response).to redirect_to(:action => "index")
      end
    end
    
  end
end