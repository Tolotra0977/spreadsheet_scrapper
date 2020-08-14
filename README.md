# spreadsheet_scrapper

Ce programme consiste a récupérer les addresses mails des mairies de la ville du val d'Oise a l'aide du lien http://annuaire-des-mairies.com/ et les stocker dans un fichier au format json,csv et Google Spreadsheet

# Fonctionnement :

Il faut d'abord installer les gem suivant :

gem 'google_drive'
gem 'json'
gem 'csv'
gem 'pry'
gem 'nokogiri'

Ensuite lancer le programme avec :
	ruby app.rb

# Composition du programme:

La Classe Scrappeur contient 6 méthodes :

1-get_townhall_email(townhall_url) : 

stocke les emails dans un hash email_array

2-get_townhall_urls(dept_url) :

Récupère et stocke toutes les urls de chaque ville du Val d'Oise dans un array

3-initialize(dept) :

Assemblage des données

4-save_as_JSON :

Lecture du fichier emails.json

5-save_as_spreadsheet :

Lecture du spreadsheet

6-save_as_csv :

Lecture du fichier emails.csv

