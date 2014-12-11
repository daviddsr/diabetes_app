require "rails_helper"

RSpec.describe ControlsController, :type => :controller do
  describe "GET index" do
    it "assigns @teams" do
      user = User.create!(
        name: "Paco",
        email: "meloinvento@invento.com",
      password: "6874357435",
      password_confirmation: "6874357435"
      )
      sign_in :user, user
      control = Control.new(
        level: 105,
        period: "pre-breakfast",
        day: Date.today)

      user.controls << control
      user.save!

      get :index
      expect(assigns(:controls)).to eq([control])
    end

    
  end
end