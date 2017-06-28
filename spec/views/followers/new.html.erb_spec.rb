require 'rails_helper'

RSpec.describe "followers/new", type: :view do
  before(:each) do
    assign(:follower, Follower.new(
      :handle_id => "MyString",
      :follower_id => "MyString"
    ))
  end

  it "renders new follower form" do
    render

    assert_select "form[action=?][method=?]", followers_path, "post" do

      assert_select "input#follower_handle_id[name=?]", "follower[handle_id]"

      assert_select "input#follower_follower_id[name=?]", "follower[follower_id]"
    end
  end
end
