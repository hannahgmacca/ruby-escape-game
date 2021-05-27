require_relative '../src/app/score_item.rb'
require 'rspec'

########## Tests for Score Item ###########

describe ScoreItem do
    before do
        @item = ScoreItem.new("pen", "Use this to write a nice note for the host", "Good work!", false, 1)
      end

    describe "collect_description" do
        it "Return the description to be printed when a user collects the item" do
          expect(@item.collect_description).to eq("Use this to write a nice note for the host")
        end
      end

      describe "use_description" do
        it "Return the description to be printed when a user uses the item" do
          expect(@item.use_description).to eq("Good work!")
        end
      end
  
     describe "is_key?" do
       it "Checks if item is a key" do
          expect(@item.is_key?).to eq false
       end
     end
  
     describe "is_item?" do
       it "Checks if item has this name" do
         expect(@item.is_item?("pen")).to eq true
       end
    end
end