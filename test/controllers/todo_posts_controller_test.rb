require 'test_helper'

class TodoPostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @todo_post = todo_posts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'TodoPost.count' do
      post todo_posts_path, params: { todo_post: {description: "HI" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'TodoPost.count' do
      delete todo_post_path(@todo_post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong todo_post" do
    log_in_as(users(:michael))
    todo_post = todo_posts(:ants)
    assert_no_difference 'TodoPost.count' do
      delete todo_post_path(todo_post)
    end
    assert_redirected_to root_url
  end
end
