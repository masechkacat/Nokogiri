require 'nokogiri'
require 'open-uri'

result = []
base_url = 'http://annuaire-des-mairies.com'
region_url = 'http://annuaire-des-mairies.com/val-d-oise.html'

district_doc_html = Nokogiri::HTML(URI.open(region_url))
city_links = district_doc_html.css('a.lientxt')

city_links.each do |city_link|
  city_name = city_link.text.strip
  city_relative_url = city_link['href'].sub(/^\./, '')
  city_url = "#{base_url}/#{city_relative_url}"

city_doc_html = Nokogiri::HTML(URI.open(city_url))

  email_elements = city_doc_html.css('td:contains("Adresse Email")')
    emails = email_elements.map { |element| element.next_element.text.strip }
  emails.each do |email|
    result << { city_name => email }
  end
end

puts result
