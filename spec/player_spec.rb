require_relative '../src/app/player.rb'
require 'rspec'

# Tests for player class and functions
describe Player do
    before do
        @player = Player.new
        @player.pick_up
    
      end

    describe "pick_up" do
        it "adds item to players backpack" do
            expect
        end
      end
  
     describe "remove_item" do
       it "removes item from players backpack" do
       end
     end
  
     describe "has_item?" do
       it "checks backpack for an item" do
         expect(player.has_item?).to be_complete
       end
    end
end