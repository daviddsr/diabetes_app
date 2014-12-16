require "rails_helper"

RSpec.describe ControlsController, :type => :controller do
  render_views

  describe "GET index" do

    let(:user) { 
    FactoryGirl.create(:user)  
    }

    let(:control) {
      FactoryGirl.create(:control, user: user)
    }
    context "logged in" do
      before :each do
        sign_in :user, user
      end

      it "loads all controls into @controls" do
        get :index, { user_id: user.name}

        expect(assigns(:controls)).to eq([control])
      end

      it "assigns a new control to @control" do
        get :index, { user_id: user.name}
        expect(assigns(:control)).to be_a_new(Control)
      end

      it "renders the index template" do 
        get :index, { user_id: user.name}
        expect(response).to render_template("index")
      end

      it "a user can't see the controls from other user" do
        new_user = User.create(name: "Juan", 
                               email: "juan@gmail.com", 
                               password: "123456789", 
                               password_confirmation: "123456789")
        get :index, { user_id: new_user.id}
        expect(response).to redirect_to user_controls_path(user.name)

      end

    describe "POST create" do
      it "stays in the controls page upon save" do
        post :create, { user_id: user.id, control: { 
                                            user_id: user.id,
                                            level: 120, 
                                            period: "pre-breakfast", 
                                            day: DateTime.now.strftime('%m/%d/%Y %I:%M %p') }}
        expect(response).to redirect_to(:action => "index")
    end

  end
  end
    
  end
end