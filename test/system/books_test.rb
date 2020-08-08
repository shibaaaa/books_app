# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:book_1)
    login_as users(:user_1)
  end

  test "本一覧ページの表示ができること" do
    visit books_url
    assert_selector "h1", text: "本"
  end

  test "本の詳細ページの表示ができること" do
    visit books_url
    click_on "詳細", match: :first
    assert_text "チェリー本"
    assert_text "Rubyの勉強ならコレは外せない"
  end

  test "本の作成ができること" do
    visit books_url
    click_on "新規作成"
    fill_in "メモ", with: "Rails本の決定版"
    fill_in "タイトル", with: "パーフェクトRails"
    click_on "登録"

    assert_text "パーフェクトRails"
    assert_text "本が保存されました"
  end

  test "本の更新ができること" do
    visit edit_book_path(@book)

    fill_in "メモ", with: "ページ数がすごい"
    fill_in "タイトル", with: "パーフェクトRuby on Rails"
    click_on "更新する"

    assert_text "パーフェクトRuby on Rails"
    assert_text "本が更新されました"
  end

  test "本を削除できること" do
    visit books_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "本が削除されました"
  end
end
