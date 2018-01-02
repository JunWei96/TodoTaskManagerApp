require 'test_helper'

class TodoPostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "todo_post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'

    #invalid submission
    assert_no_difference 'TodoPost.count' do
      post todo_posts_path, params: { todo_post: { description: "",
                                                  due_date: "22/03/2018" } }
    end

    assert_redirected_to root_url
    follow_redirect!
    assert !flash.empty?

    #valid submission
    description = "valid description!"
    assert_difference 'TodoPost.count', 1 do
      post todo_posts_path, params: { todo_post: { description: description,
                                                  due_date: "22/03/2018" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match description, response.body

    #delete post
    first_todo_post = @user.todo_posts.paginate(page: 1).first
    assert_difference 'TodoPost.count', -1 do
      delete todo_post_path(first_todo_post)
    end

    #visit different user (no delete link)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

end
