# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report_1)
    login_as users(:user_1)
  end

  test "日報一覧ページの表示ができること" do
    visit books_url
    click_on "日報一覧"
    assert_selector "h1", text: "日報一覧"
  end

  test "日報の詳細ページの表示ができること" do
    visit reports_path
    click_on "詳細", match: :first
    assert_text "今日の成果"
    assert_text "今日は集中して勉強できた"
  end

  test "日報の作成ができること" do
    visit reports_path
    click_on "新規作成"
    fill_in "タイトル", with: "タイトル"
    fill_in "内容", with: "内容"
    click_on "登録"

    assert_text "日報を登録しました"
  end

  test "日報の更新ができること" do
    visit edit_report_path(@report)

    fill_in "タイトル", with: "タイトル更新"
    fill_in "内容", with: "内容更新"
    click_on "更新する"

    assert_text "日報を更新しました"
  end

  test "日報を削除できること" do
    visit reports_path
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "日報が削除されました"
  end
end
