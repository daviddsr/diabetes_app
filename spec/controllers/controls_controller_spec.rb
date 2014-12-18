require "rails_helper"

RSpec.describe ControlsController, :type => :controller do
  render_views

    let(:user) { 
      FactoryGirl.create(:user)  
    } 
    let(:control) {
      FactoryGirl.create(:control, user: user)
    }
    let(:valid_control_attributes) { FactoryGirl.attributes_for(:control) }

    
    before :each do
      sign_in :user, user
    end
  describe "GET index" do


    context "logged in" do

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
        new_user = User.create(
          name: "Juan", 
          email: "juan@gmail.com", 
          password: "123456789", 
          password_confirmation: "123456789")
        get :index, { user_id: new_user.id}
        expect(response).to redirect_to user_controls_path(user.name)

      end

      describe "GET calendar" do
        it "loads all controls from a user in a JSON format" do
          control = FactoryGirl.create(
          :control, 
          user: user, 
          level: 120
          )
          get :calendar, { user_id: user.id}
          controls = JSON.parse response.body
          expected_json = [{"id" => control.id,
                            "level" => control.level,
                            "day" => control.day.strftime('%m/%d/%Y %I:%M %p')
                            }]
          expect(controls).to eq(expected_json)
        end
      end

      describe "GET edit" do
        it "assigns the requested control as a @control" do
          control = FactoryGirl.create(:control, user: user)
          get :edit, { user_id: user.id, id: control.id}
          expect(assigns :control).to eq(control)
        end
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

    it "a user can create a new Control" do
      post :create, { user_id: user.id, control: {
                                            user_id: user.id,
                                            level: 175,
                                            period: "pre-breakfast",
                                            day: DateTime.now.strftime('%m/%d/%Y %I:%M %p') }}
        expect(Control.count).to eq(1)

      end

    end
    describe "PUT update" do
      it "updates the requested control" do
        Control.any_instance.should_receive(:update_attributes).with({ "level" => "150" })
        put :update, { 
          user_id: user.id, 
          id: control.id, 
          :control => { "level" => 150 } }
      end
      it "assigns the requested control as @control" do
        control = FactoryGirl.create(:control, user: user)
        put :update, { user_id: user.id, id: control.id, :control => valid_control_attributes }
        expect(assigns(:control)).to eq(control)
      end

    end
  end
    
  end
end