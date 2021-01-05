require 'rails_helper'

feature "Working with flight plans" do

  scenario "Pressing the Delete All button" do
    create(:flight_plan)
    visit '/flight_plans'
    expect(page).to have_selector('table tbody tr td')
    click_button 'Delete All'
    expect(page).to have_current_path('/flight_plans')
    expect(page).not_to have_selector('table tbody tr td')
  end

  scenario "Pressing the Download button" do
    visit '/flight_plans'
    expect(page).not_to have_selector('table tbody tr td')
    click_button 'Download'
    expect(page).to have_current_path('/flight_plans')
    expect(page).to have_selector('table tbody tr td')
  end
end