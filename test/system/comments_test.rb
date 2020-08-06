# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    login_as users(:user_1)
    @book = books(:book_1)
    @report = reports(:report_1)
    @book_comment = comments(:comment_1)
    @report_comment = comments(:comment_2)
  end

  test "本へのコメントが表示できること" do
    visit book_path(@book)
    assert_text "コメントです"
  end

  test "日報へのコメントが表示できること" do
    visit report_path(@report)
    assert_text "これはコメント"
  end

  test "本へのコメント投稿ができること" do
    visit book_path(@book)
    fill_in "内容", with: "おはよう"
    click_on "登録する"

    assert_text "コメントを投稿しました"
    assert_text "おはよう"
  end

  test "日報へのコメント投稿ができること" do
    visit report_path(@report)
    fill_in "内容", with: "こんにちは"
    click_on "登録する"

    assert_text "コメントを投稿しました"
    assert_text "こんにちは"
  end

  test "本へのコメントが更新ができること" do
    visit edit_book_comment_path(@book, @book_comment)
    fill_in "内容", with: "コメント更新"
    click_on "更新する"

    assert_text "コメントを更新しました"
    assert_text "コメント更新"
  end

  test "日報へのコメントが更新ができること" do
    visit edit_report_comment_path(@report, @report_comment)
    fill_in "内容", with: "これはコメント更新"
    click_on "更新する"

    assert_text "コメントを更新しました"
    assert_text "これはコメント更新"
  end

  test "本へのコメントを削除できること" do
    visit book_path(@book)
    page.accept_confirm do
      find("#delete_comment").click
    end

    assert_text "コメントが削除されました"
    assert_no_text "コメントです"
  end

  test "日報へのコメントを削除できること" do
    visit report_path(@report)
    page.accept_confirm do
      find("#delete_comment").click
    end

    assert_text "コメントが削除されました"
    assert_no_text "これはコメント"
  end
end
