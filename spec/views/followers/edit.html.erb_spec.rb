require 'rails_helper'

RSpec.describe "followers/edit", type: :view do
  before(:each) do
    @follower = assign(:follower, Follower.create!(
      :handle_id => "MyString",
      :follower_id => "MyString"
    ))
  end

  it "renders the edit follower form" do
    render

    assert_select "form[action=?][method=?]", follower_path(@follower), "post" do

      assert_select "input#follower_handle_id[name=?]", "follower[handle_id]"

      assert_select "input#follower_follower_id[name=?]", "follower[follower_id]"
    end
  end
end
