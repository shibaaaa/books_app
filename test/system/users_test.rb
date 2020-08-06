# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    login_as users(:user_1)
    @user = users(:user_1)
  end

  test "ユーザー一覧ページの表示ができること" do
    visit root_path
    click_on "ユーザー一覧"
    assert_selector "h1", text: "ユーザー一覧"
  end

  test "ユーザープロフィールページの表示ができること" do
    visit root_path
    click_on "プロフィール"
    assert_text "ユーザー1"
  end

  test "ユーザープロフィールの更新ができること" do
    visit edit_user_registration_path
    fill_in "ユーザー名", with: "ユーザー名更新"
    click_on "更新"
    assert_text "ユーザー名更新"
  end

  test "ユーザーを削除できること" do
    visit edit_user_registration_path
    page.accept_confirm do
      click_on "アカウント削除", match: :first
    end
    assert_text "アカウント登録もしくはログインしてください。"
  end
end
