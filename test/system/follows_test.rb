# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  setup do
    login_as users(:user_1)
    @user = users(:user_1)
    @other = users(:user_2)
  end

  test "フォローすることとフォロー解除すること" do
    visit user_path(@other)
    click_on "フォローする"
    assert_text "フォロワー 1"

    click_on "フォロー解除"
    assert_text "フォロワー 0"
  end

  test "フォロー一覧ページが表示できること" do
    visit user_path(@user)
    click_on "フォロー"
    assert_text "#{@user.name}のフォロー"
  end

  test "フォロワー一覧ページが表示できること" do
    visit user_path(@user)
    click_on "フォロワー"
    assert_text "#{@user.name}のフォロワー"
  end
end
