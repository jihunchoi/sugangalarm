require 'open-uri'
require 'nokogiri'
class Alarm < ActiveRecord::Base
  def self.check
    Alarm.all.each do |alarm|
      url = "http://sugang.snu.ac.kr/sugang/cc/cc100.action?srchCond=1&pageNo=1&workType=S&srchOpenSchyy=2014&currSchyy=2014&srchOpenShtm=U000200001U000300001&currShtmNm=1%ED%95%99%EA%B8%B0"
      url += "&srchSbjtCd=" + alarm.subject_code
      url += "&srchProfNm=" + alarm.lecturer
      url = URI::escape(url)
      doc = Nokogiri::HTML(open(url).read)
      max_registrant = doc.xpath('//*[@id="content"]/div/div[3]/div[1]/div[2]/table/tbody/tr[1]/td[15]').children[0].to_s.to_i
      current_registrant = doc.xpath('//*[@id="content"]/div/div[3]/div[1]/div[2]/table/tbody/tr[1]/td[16]').children[0].to_s.to_i
      if current_registrant < max_registrant
        unless alarm.alarmed?
          Mailer.send_alarm(alarm.id).deliver
          alarm.update_attribute(:alarmed, true)
        end
      elsif 
        alarm.update_attribute(:alarmed, false)
      end
    end
  end
end
