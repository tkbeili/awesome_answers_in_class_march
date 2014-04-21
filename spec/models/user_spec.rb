require "spec_helper"


describe User do

  describe ".full_name" do

    it "includes first_name if it exists" do
      user = User.new(first_name: "Tam", 
                         last_name: "Kbeili",
                         email: "tam@codecore.ca")
      expect(user.full_name).to eq("Tam Kbeili")
    end

    it "includes email if first_name and last_name are absent" do
      user = User.new(email: "tam@codecore.ca")
      expect(user.full_name).to eq("tam@codecore.ca")
    end


  end

end