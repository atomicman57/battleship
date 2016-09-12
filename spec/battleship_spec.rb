require_relative '../battleship_methods.rb'

RSpec.describe 'battleship methods' do

  describe "setup_game" do
    it "does not raise error" do
      allow(Input).to receive(:get_orientation).and_return "h"
      allow(Input).to receive(:get_coordinates).and_return("a1", "a2", "a3", "a4", "a5")
      expect{ setup_game }.to_not raise_error
    end
  end

end
