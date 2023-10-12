require 'nokogiri'
require 'open-uri'

def scrape_crypto_data
  url = 'https://coinmarketcap.com/all/views/all/'
  document_html = Nokogiri::HTML(URI.open(url))
  crypto_data = []

  rows = document_html.css('tr.cmc-table-row')

  rows.each do |row|
    symbol = row.css('td.cmc-table__cell.cmc-table__cell--sort-by__symbol').text
    price = row.css('td.cmc-table__cell.cmc-table__cell--sort-by__price span').text.gsub('$', '').to_f

    crypto_data << { symbol => price } unless symbol.empty?
  end

  crypto_data
end

puts scrape_crypto_data
