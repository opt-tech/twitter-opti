require 'rails_helper'

RSpec.describe "followers/index", type: :view do
  before(:each) do
    assign(:followers, [
      Follower.create!(
        :handle_id => "Handle",
        :follower_id => "Follower"
      ),
      Follower.create!(
        :handle_id => "Handle",
        :follower_id => "Follower"
      )
    ])
  end

  it "renders a list of followers" do
    render
    assert_select "tr>td", :text => "Handle".to_s, :count => 2
    assert_select "tr>td", :text => "Follower".to_s, :count => 2
  end
end
