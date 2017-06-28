require 'rails_helper'

RSpec.describe "followers/show", type: :view do
  before(:each) do
    @follower = assign(:follower, Follower.create!(
      :handle_id => "Handle",
      :follower_id => "Follower"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Handle/)
    expect(rendered).to match(/Follower/)
  end
end
