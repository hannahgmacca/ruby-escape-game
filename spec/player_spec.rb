require_relative '../src/app/player.rb'
require 'rspec'

########## Tests for player class and functions ###########
describe Player do
    before do
        @player = Player.new
      end

    describe "pick_up" do
        it "adds item to players backpack" do
          @player.pick_up("key")
          expect(@player.backpack[0]).to eq("key")
        end
      end
  
     describe "remove_item" do
       it "removes item from players backpack" do
        @player.pick_up("key")
        @player.remove_item("key")
          expect(@player.backpack).to be_empty
       end
     end
  
     describe "has_item?" do
       it "checks backpack for an item" do
        @player.pick_up("key")
         expect(@player.has_item?("key")).to eq true
       end
    end
end