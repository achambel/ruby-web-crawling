# coding: utf-8

require 'mechanize'

login_url = ENV['LOGIN_URL']
user_name = ENV['USERNAME']
password = ENV['PASSWORD']
find_by_proccess = ENV['PROCCESS']

agent = Mechanize.new
page = agent.get(login_url)
form = page.form_with(:id => 'loginform')

form['LoginForm[username]'] = user_name
form['LoginForm[password]'] = password

page = form.submit

detail = page.link_with(href: "/intra-manager/requisition/update/id/#{find_by_proccess}").click

detail.search('#sort-table tbody tr').each do |tr|
	puts tr.text.strip
end

page.link_with(href:'/intra-manager/login/exit/').click
