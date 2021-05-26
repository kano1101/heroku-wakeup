require 'watir'
require 'headless'
require_relative './line_notify.rb'

class HerokuBrowser

  def self.start(app_name)
    headless = Headless.new
    headless.start
    new(app_name).restart_until_success
    headless.destroy
  end
  
  def initialize(app_name)
    @app_name = app_name
    @browser = Watir::Browser.new :chrome, headless: true
  end
  
  def goto_app_url
    url = "https://#{@app_name}.herokuapp.com"
    @browser.goto(url)
  end
  def refresh_page
    @browser.refresh
  end
  def wait_a_little
    sleep 30
  end
  def success?
    @browser.title =~ /#{@app_name}/
  end
  def restart_heroku
    %x[heroku restart web.1 -a #{@app_name}]
  end
  def refresh_5times_or_success
    5.times do
      print '.'
      begin
        refresh_page
        wait_a_little
      rescue
        redo
      end
      return true if success?
    end
    false
  end
  def restart_until_success
    puts 'Herokuアプリ起動まで更新します。'
    send("Heroku起動プログラムが開始されました。")
    
    goto_app_url
    until refresh_5times_or_success
      puts "リスタートを実行します。"
      restart_heroku
    end
    
    puts 'Herokuアプリが起動しました。プログラムを終了します。'
    send("Herokuが起動しました。サイトを確認してください。")
    'done.'
  end
  def send(message)
    LineNotify.send(message)
  end
end
