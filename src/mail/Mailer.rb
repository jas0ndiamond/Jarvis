require 'net/smtp'
require 'tlsmail'

class Mailer
  def self.send_mail(external_ip, config) 
    config['mailing_list'].each do |dest|
      Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
      Net::SMTP.start(config['smtp_server'], config['smtp_port'], config["smtp_domain"], config['smtp_user'], config['smtp_pass'], :plain) do |smtp|
        smtp.send_message config["message"], config['smtp_user'], dest
      end
    end
  end
end