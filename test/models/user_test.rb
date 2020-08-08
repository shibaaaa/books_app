# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @yamada = users(:user_1)
    @tanaka = users(:user_2)
  end

  test "フォローできることを確認" do
    @yamada.follow(@tanaka)
    assert @yamada.following?(@tanaka)
  end

  test "フォロー解除できることを確認" do
    @yamada.follow(@tanaka)
    @yamada.unfollow(@tanaka)
    assert_not @yamada.following?(@tanaka)
  end

  test "現在のパスワードなしでユーザーの情報を更新できることを確認" do
    assert_equal @yamada.name, "ユーザー1"
    @yamada.update_without_current_password(name: "山田")
    assert_equal @yamada.name, "山田"
  end

  test "登録済みユーザーをOAuth認証情報から発見する" do
    auth = OmniAuth::AuthHash.new(
      uid: "2",
      provider: "github",
      info: {
        name: "ユーザー2",
        email: "user2@example.com"
      }
    )
    auth_user = User.find_for_github_oauth(auth)
    assert @tanaka == auth_user
  end
end
