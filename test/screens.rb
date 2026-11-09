# frozen_string_literal: true

# Screenshots of Redmine's own screens for the docs (bin/screenshots). Each
# screen is saved in English into docs/images/ and in Japanese into
# docs/ja/images/, cropped to an element of the page. Redmine's test data
# (all fixtures, as Redmine's test helper loads them) fills the screens.
require File.expand_path('../application_system_test_case', __dir__)

class DesignGuideScreens < ApplicationSystemTestCase
  DOCS = '/redmine/design-guide-docs'
  LANGUAGES = { 'en' => 'images', 'ja' => 'ja/images' }.freeze

  def test_screens
    each_language do |language|
      shoot_page '/users', 'page-header', language
      shoot_page '/roles/1/edit', 'sections', language, hide_after: '#permissions'
      shoot_page '/enumerations', 'list', language
      shoot_page '/admin/info', 'information', language
      shoot_page '/settings?tab=general', 'settings', language
      shoot_page '/settings?tab=notifications', 'settings-checkboxes', language
      shoot_page '/projects/ecookbook/issues/new', 'form', language
      # A project without issue categories shows the empty state.
      shoot_page '/projects/subproject1/settings/categories', 'empty', language
      shoot_page '/projects/ecookbook/settings', 'project-settings', language
      shoot_page '/trackers/1/edit', 'split', language
      shoot_page '/projects/ecookbook/issues', 'sidebar', language, selector: '#main'

      visit '/projects/new'
      find('#new_project input[name=commit]').click
      assert_selector '#errorExplanation'
      shoot 'form-errors', language

      visit '/settings?tab=general'
      find('#tab-content-general input[type=submit]').click
      assert_selector 'div.flash.notice'
      hide_after 'div.tabs'
      shoot 'flash', language
    end
  end

  private

  # Runs the block once per language, logged in as the administrator with
  # that language.
  def each_language
    LANGUAGES.each_key do |language|
      User.find(1).update!(language: language)
      Capybara.reset_sessions!
      page.driver.browser.manage.window.resize_to(1280, 900)
      log_user('admin', 'admin')
      yield language
    end
  end

  def shoot_page(path, name, language, selector: '#content', hide_after: nil)
    visit path
    assert_selector selector
    hide_after(hide_after) if hide_after
    shoot name, language, selector: selector
  end

  # Hides the siblings after the element, to keep a screenshot to the part
  # the docs describe.
  def hide_after(selector)
    page.execute_script(<<~JS)
      var node = document.querySelector(#{selector.to_json});
      while (node && (node = node.nextElementSibling)) { node.style.display = 'none'; }
    JS
  end

  # Saves the element as docs/<images>/<name>.png. The window grows to the
  # element's height first, since Chrome only captures what is in the window;
  # the focused field loses its caret.
  def shoot(name, language, selector: '#content')
    element = page.find(selector)
    # #content and #main stretch to the window's height in the flex layout;
    # sized to their content, the image ends with the content instead of a
    # blank area.
    page.execute_script(<<~JS)
      document.querySelector('#content').style.alignSelf = 'flex-start';
      document.querySelector('#main').style.flexGrow = '0';
    JS
    bottom = page.evaluate_script("document.querySelector(#{selector.to_json}).getBoundingClientRect().bottom")
    page.driver.browser.manage.window.resize_to(1280, [bottom.ceil + 200, 900].max)
    page.execute_script('window.scrollTo(0, 0); document.activeElement?.blur()')
    path = File.join(DOCS, LANGUAGES.fetch(language), "#{name}.png")
    element.native.save_screenshot(path)
    assert File.size?(path), "no screenshot at #{path}"
    # 256 colors are enough for Redmine's flat colors; keeps the original when
    # that would not be smaller.
    system('pngquant', '--quality=85-98', '--skip-if-larger', '--strip', '--force', '--ext', '.png', path)
    page.driver.browser.manage.window.resize_to(1280, 900)
  end
end
