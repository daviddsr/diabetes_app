require "rails_helper"

RSpec.describe Control, :type => :model do
    
    it "has a valid factory" do
      expect(FactoryGirl.create(:control)).to be_valid
    end

    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:period) }
    it { should validate_presence_of(:day) }

    let(:user) { FactoryGirl.create :user }

    it "returns last control level" do
      FactoryGirl.create(:control, user: user)
      last_control = Control.create(
        user_id: user.id,
        level: 112, 
        period: "pre-breakfast",
        day: DateTime.now
        )

      expected_value = Control.last_control_level(user.id)
      
      expect(expected_value).to eq last_control.level
    end

    it "returns error if a level is less than 25" do
      control = Control.create(
          user_id: user.id, 
          level: 20,
          period: "pre-breakfast", 
          day: DateTime.now
          )
      expect(control).not_to be_valid
    end

    it "returns error if a level is higher than 600" do
      control = Control.create(
          user_id: user.id, 
          level: 601,
          period: "pre-breakfast", 
          day: DateTime.now
          )
      expect(control).not_to be_valid
    end

    it "returns error if user enter not a number" do
      control = Control.create(
          user_id: user.id, 
          level: "gdfhagl",
          period: "pre-breakfast", 
          day: DateTime.now
          )
      expect(control).not_to be_valid
    end

    xit "if it has not been more than 30 minutes since the last control, the new control returns error" do
      control = Control.create(
        user_id: user.id,
        level: 112, 
        period: "pre-breakfast",
        day: DateTime.now 
        )
      control2 = Control.create(
        user_id: user.id,
        level: 112, 
        period: "pre-breakfast",
        day: DateTime.now + 15.minutes
        )
      expect(control2).not_to be_valid

    end

    describe ".levels_average" do
      
      it "returns 0 if there are no controls" do
        average = Control.levels_average user.id
        expect(average).to eq 0
      end

      it "if there is one control returns the level of that control" do
        control = FactoryGirl.create(:control, user: user)
        average = Control.levels_average user.id
        expect(average).to eq control.level
      end

      it "if there is more than one control returns the average level of those controls" do
        control = FactoryGirl.create(
          :control, 
          user: user, 
          level: 120
          )
        control2 = Control.create(
          user_id: user.id, 
          level: 106, 
          period: "pre-breakfast", 
          day: DateTime.now
          )
        control3 = Control.create(
          user_id: user.id, 
          level: 104, 
          period: "pre-breakfast", 
          day: DateTime.now
          )
        average = Control.levels_average user.id
        expect(average).to eq 110
      end
    end
      
    describe ".controls_by_day_average" do
     
      it "returns 0 if there are no controls" do
        day_average = Control.controls_by_day_average user.id
        expect(day_average).to eq 0.0
      end

      it "if user has signed up today and if there is one control it returns 1" do
        control = FactoryGirl.create(:control, user: user)
        day_average = Control.controls_by_day_average user.id
        expect(day_average).to eq 1.0
      end

      it "if the first control was four days ago and there are no more controls, it returns 0.25" do
        control = FactoryGirl.create(:control, user: user, day: DateTime.now - 4.days)
        day_average = Control.controls_by_day_average user.id
        expect(day_average).to eq 0.25
      end
    end
    
    describe ".graphic_data_for_all_days" do
      before do
        Timecop.freeze(DateTime.now)
      end

      after do
        Timecop.return
      end
     
      it "returns no data if there are no controls" do
        graphic_data_for_all_days = Control.graphic_data_for_all_days(user.id)
        expect(graphic_data_for_all_days).to eq([])
      end

      xit "if there are 3 controls in one day and another one other day, it returns a couple of hashes with data listed by days" do
        time = DateTime.now
        control = FactoryGirl.create(
          :control, 
          user: user, 
          level: 120,
          day: time
          )
        control2 = FactoryGirl.create(
          :control,
          user:user, 
          level: 106, 
          period: "pre-breakfast", 
          day: time + 3.hours
          )
        control3 = FactoryGirl.create(
          :control,
          user: user, 
          level: 104, 
          period: "pre-breakfast", 
          day: time + 6.hours
          )
        control4 = FactoryGirl.create(
          :control,
          user: user, 
          level: 104, 
          period: "pre-breakfast", 
          day: time + 24.hours
          )
        graphic_data_for_all_days = Control.graphic_data_for_all_days(user.id)
        expect(graphic_data_for_all_days[0][:data].count).to eq(3)
        expect(graphic_data_for_all_days[0][:data][0][1]).to eq(120)
        expect(graphic_data_for_all_days[0][:data][2][1]).to eq(104)
      end

      xit "the controls are ordered from older to newer" do
        # time = DateTime.now.to_i
        # DateTime.stub!(:now).and_return{DateTime.at(time += 5) }
        control = FactoryGirl.create(
          :control, 
          user: user, 
          level: 120,
          day: Timecop.freeze(DateTime.now)
          )
        control2 = Control.create(
          user_id: user.id, 
          level: 106, 
          period: "pre-breakfast", 
          day: Timecop.freeze(DateTime.now + 3.hours)
          )
        control3 = Control.create(
          user_id: user.id, 
          level: 104, 
          period: "pre-breakfast", 
          day: Timecop.freeze(DateTime.now + 6.hours)
          )
        control4 = Control.create(
          user_id: user.id, 
          level: 104, 
          period: "pre-breakfast", 
          day: Timecop.freeze(DateTime.now + 9.hours)
          )
         graphic_data_for_all_days = Control.graphic_data_for_all_days(user.id)
         expect(graphic_data_for_all_days).to eq ([{
          name: "day", 
          data:[
            [Timecop.freeze(DateTime.now).strftime("%I:%M%p").to_time.utc.to_i * 1000, 120],
            [(Timecop.freeze(DateTime.now + 3.hours)).strftime("%I:%M%p").to_time.utc.to_i * 1000, 106],
            [(Timecop.freeze(DateTime.now + 6.hours)).strftime("%I:%M%p").to_time.utc.to_i * 1000, 104],
            [(Timecop.freeze(DateTime.now + 9.hours)).strftime("%I:%M%p").to_time.utc.to_i * 1000, 104] 
            ]
            }])
      end
  end
end