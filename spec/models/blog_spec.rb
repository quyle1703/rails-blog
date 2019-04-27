require 'rails_helper'

RSpec.describe Blog, type: :model do
  it "has a valid factory" do
    subject { build :blog } 
    expect(subject).to be_valid
  end
end