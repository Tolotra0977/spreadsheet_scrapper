#!/usr/bin/env ruby
class Scrapper

  # Definition de la méthode get_townhall_email(townhall_url)
  #stockage des emails dans un hash email_array

    def get_townhall_email(townhall_url)
       page = Nokogiri::HTML(open(townhall_url)) 
       email_array = []
       email = page.xpath('//*[contains(text(), "@")]').text
       town = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split 
       email_array << {town[3] => email} 
       puts email_array
       return email_array
    end

  
  # Récupération des urls de chaque ville du Val d'Oise 
  # Stockage de l'url dans un array 

    def get_townhall_urls(dept_url)
      page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
      url_array = []
      urls = page.xpath('//*[@class="lientxt"]/@href') 
      urls.each do |url| 
      url = "http://annuaire-des-mairies.com/"+ url.text[1..-1] 
      url_array << url
    end
      return url_array
    end

  #Assemblage de l'url et de l'email

    def initialize(dept)
       @array=[]
       get_townhall_urls(dept).map{|i| @array << get_townhall_email(i)}
       return @array
    end

  #Lecture du fichier emails.json
    def save_as_JSON
       File.open("db/emails.json","w") do |f|
       f.write(@array.map{|i| Hash[i.each_pair.to_a]}.to_json)
    end
    end

  #Lecture du fichier spreadsheet
  	def save_as_spreadsheet
      session = GoogleDrive::Session.from_config("config.json")
      ws = session.spreadsheet_by_key("1hL7MdDOl9JqmuSuTkAeN3Q1w2CqCU3fU0aUHQkm3ldg").worksheets[0]
      ws[1, 1] = @array.first.keys[0]
      ws[1, 2] = @array.first.keys[1]
      @array.map.with_index{|hash,index|
        ws[index+2, 1] = hash['ville']
        ws[index+2, 2] = hash['email']
      }
      ws.save
  	end  

  	#Lecture du fichier emails.csv
  def save_as_csv
      CSV.open("db/emails.csv", "wb") do |csv|
      csv << @array.first.keys
      @array.each do |hash|
      csv << hash.values
      end
    end
  end
end