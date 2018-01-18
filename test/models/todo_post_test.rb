require 'test_helper'

class TodoPostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @todo_post = @user.todo_posts.build(description: "test",
                              due_date: "4/2/2018", user_id: @user.id)
  end

  test "should be valid" do
    assert @todo_post.valid?
  end

  test "user id should be present" do
    @todo_post.user_id = nil
    assert_not @todo_post.valid?
  end

  test "description must be present" do
    @todo_post.description = "    "
    assert_not @todo_post.valid?
  end

  test "description should be at most 140 characters" do
    @todo_post.description = "a" * 141
    assert_not @todo_post.valid?
  end

end
