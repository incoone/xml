class HomeController < ApplicationController
  def index
  end

  def show
    if (params[:key]=='' || params[:key].nil? || params[:phone]=='' || params[:phone].nil?)
      @out = '<div class="py-5"><div class="container"><div class="bg-danger text-white">Podaj przydzielony klucz i swój nr telefonu.</div></div></div>'
    else
      orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
      user_transform = File.join(Rails.root, 'app', 'assets', 'data', 'user.xsl')
      inquiries = File.join(Rails.root, 'app', 'assets', 'data', 'Inquiries.xml')

      doc = Nokogiri::XML(File.read(orders))
      xslt = Nokogiri::XSLT(File.read(user_transform))

      doc_inquiries = Nokogiri::XML(File.read(inquiries))
      c = doc_inquiries.search('inquiries')
      doc.at('/descendant::Orders').add_child(c)

      puts c.to_xml
      @out = xslt.transform(doc, ["key", params[:key], 'main_phone', params[:phone]])
    end
  end


  def apply
    @message = MessageGenerateKey.new
    @message.phone = params[:phone]
    if !@message.valid?
      @message.bool_is_good = false
    else
      key = rand(1..100000) #(0...4).map {(65 + rand(26)).chr}.join
      inquiries = File.join(Rails.root, 'app', 'assets', 'data', 'Inquiries.xml')
      doc = Nokogiri::XML(File.read(inquiries))
      doc.to_xml

      inquiry = Nokogiri::XML::Node.new "inquiry", doc
      inquiry['Key'] = key
      mail = Nokogiri::XML::Node.new "mail", doc
      mail.content = params[:mail]
      inquiry << mail

      name = Nokogiri::XML::Node.new "name", doc
      name.content = params[:name]
      inquiry << name

      phone = Nokogiri::XML::Node.new "phone", doc
      phone.content = params[:phone]
      inquiry << phone

      date = Nokogiri::XML::Node.new "date", doc
      date.content = params[:date]
      inquiry << date

      comment = Nokogiri::XML::Node.new "comment", doc
      comment.content = params[:comment]
      inquiry << comment

      package = Nokogiri::XML::Node.new "package", doc
      package.content = params[:package]
      inquiry << package
      # new_entry.add_child(para.to_xml + "\n")
      doc.root.add_child(inquiry.to_xml + "\n")
      doc = doc.to_xml
      File.write(inquiries, doc)

      @message.bool_is_good = true
      @message.key = key
      @message.phone = params[:phone]
    end
    #{"package"=>"option2", "comment"=>"tresc komentarza", "name"=>"Piotr", "mail"=>"piotr@dl", "phone"=>"508368998", "date"=>"05.01.2018"}
  end

end
