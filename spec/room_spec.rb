require_relative '../src/app/room.rb'
require 'rspec'

########## Tests for room class and functions ###########
describe Room do
  before do
    @room = Room.new("diningroom", "charger", {:west => "bedroom"})
  end

  describe "has_exit?" do
      it "Returns true if room has this exit" do
        expect(@room.has_exit?("west")).to eq true
      end
    end

  describe "get_exit" do
    it "Returns the exit the direction leads to" do
      expect(@room.get_exit("west")).to eq "bedroom"
    end
  end

  describe "has_item?" do
    it "Checks if item is in room" do
      expect(@room.has_item?("charger")).to eq true
    end
  end

describe "has_items?" do
  it "Checks if there are any items in room" do
    expect(@room.has_items?).to eq true
  end
end

describe "is_room?" do
  it "Returns true if room has that name" do
    expect(@room.is_room?("diningroom")).to eq true
  end
end

end