class AdminController < ApplicationController
  def index
    @admin_index = AdminIndex.new
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    admin_new_apply_transform = File.join(Rails.root, 'app', 'assets', 'data', 'admin_new_apply.xsl')
    inquiries = File.join(Rails.root, 'app', 'assets', 'data', 'Inquiries.xml')

    doc = Nokogiri::XML(File.read(orders))
    xslt = Nokogiri::XSLT(File.read(admin_new_apply_transform))

    doc_inquiries = Nokogiri::XML(File.read(inquiries))
    c = doc_inquiries.search('inquiries')
    doc.at('/descendant::Orders').add_child(c)

    puts c.to_xml
    @admin_index.new_apply_html = xslt.transform(doc)

  end

  def id
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    user_transform = File.join(Rails.root, 'app', 'assets', 'data', 'admin_order.xsl')
    inquiries = File.join(Rails.root, 'app', 'assets', 'data', 'Inquiries.xml')

    doc = Nokogiri::XML(File.read(orders))
    xslt = Nokogiri::XSLT(File.read(user_transform))

    doc_inquiries = Nokogiri::XML(File.read(inquiries))
    c = doc_inquiries.search('inquiries')
    doc.at('/descendant::Orders').add_child(c)

    puts c.to_xml
    @out = xslt.transform(doc, ["key", params[:id]]) #, 'main_phone', params[:phone]])
  end

  def info
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    property = doc.xpath("//Order[@Key=" + params[:id] + "]/Information")[0]
    property.content = params[:information]
    doc = doc.to_xml
    File.write(orders, doc)
  end

  def event
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    propEvent = doc.xpath("//Event[@uuid='" + params[:uuid] + "']")[0]

    propEvent.xpath("EventName")[0].content = params[:EventName]
    propEvent.xpath("EventAddress/Comment")[0].content = params[:EComment]
    propEvent.xpath("EventAddress/FullAddress/Country")[0].content = params[:EFCountry]
    propEvent.xpath("EventAddress/FullAddress/State")[0].content = params[:EFState]
    propEvent.xpath("EventAddress/FullAddress/City")[0].content = params[:EFCity]
    propEvent.xpath("EventAddress/FullAddress/Zip")[0].content = params[:EFZip]
    propEvent.xpath("EventAddress/FullAddress/Address")[0].content = params[:EFAddress]
    propEvent.xpath("EventAddress/Comment")[0].content = params[:EComment]
    propEvent.xpath("StartDate")[0].content = params[:StartDate]
    propEvent.xpath("EndDate")[0].content = params[:EndDate]
    doc = doc.to_xml
    File.write(orders, doc)
  end

  def customer
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    propCustomer = doc.xpath("//Customer[@uuid='" + params[:uuid] + "']")[0]
    propCustomer.xpath("CustomerName/FName")[0].content = params[:FName]
    propCustomer.xpath("CustomerName/LName")[0].content = params[:LName]
    propCustomer.xpath("Company/CompanyName")[0].content = params[:CompanyName]
    propCustomer.xpath("Company/TaxNo")[0].content = params[:TaxNo]
    propCustomer.xpath("FullAddress/Address")[0].content = params[:Address]
    propCustomer.xpath("FullAddress/Zip")[0].content = params[:Zip]
    propCustomer.xpath("FullAddress/City")[0].content = params[:City]
    propCustomer.xpath("FullAddress/State")[0].content = params[:State]
    propCustomer.xpath("FullAddress/Country")[0].content = params[:Country]
    propCustomer.xpath("TelNo")[0].content = params[:TelNo]
    propCustomer.xpath("Mail")[0].content = params[:Mail]
    doc = doc.to_xml
    File.write(orders, doc)
  end

  def eventAdd
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    doc.to_xml

    order = doc.xpath("//Order[@Key=" + params[:id] + "]")[0]

    event = Nokogiri::XML::Node.new("Event", doc)
    event['uuid'] = SecureRandom.uuid

    eventName = Nokogiri::XML::Node.new("EventName", doc)
    eventName.content = params[:EventName]
    event << eventName

    startDate = Nokogiri::XML::Node.new("StartDate", doc)
    startDate.content = params[:StartDate]
    event << startDate

    endDate = Nokogiri::XML::Node.new("EndDate", doc)
    endDate.content = params[:EndDate]
    event << endDate

    eventAddress = Nokogiri::XML::Node.new("EventAddress", doc)

    eventComment = Nokogiri::XML::Node.new("Comment", doc)
    eventComment.content = params[:EComment]
    eventAddress << eventComment

    fullAddress = Nokogiri::XML::Node.new("FullAddress", doc)

    country = Nokogiri::XML::Node.new("Country", doc)
    country.content = params[:EFCountry]
    fullAddress << country

    state = Nokogiri::XML::Node.new("State", doc)
    state.content = params[:EFState]
    fullAddress << state

    city = Nokogiri::XML::Node.new("City", doc)
    city.content = params[:EFCity]
    fullAddress << city

    address = Nokogiri::XML::Node.new("Address", doc)
    address.content = params[:EFAddress]
    fullAddress << address

    zip = Nokogiri::XML::Node.new("Zip", doc)
    zip.content = params[:EFZip]
    fullAddress << zip

    eventAddress << fullAddress
    event << eventAddress

    order.add_child(event.to_xml + "\n")
    # new_entry.add_child(para.to_xml + "\n")
    #doc.root.add_child(event.to_xml + "\n")
    doc = doc.to_xml
    File.write(orders, doc)
    redirect_back(fallback_location: root_path)
  end

  def customerAdd
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    doc.to_xml

    order = doc.xpath("//Order[@Key=" + params[:id] + "]")[0]

    customer = Nokogiri::XML::Node.new("Customer", doc)
    customer['uuid'] = SecureRandom.uuid

    customerName = Nokogiri::XML::Node.new("CustomerName", doc)

    fName = Nokogiri::XML::Node.new("FName", doc)
    fName.content = params[:FName]
    customerName << fName

    lName = Nokogiri::XML::Node.new("LName", doc)
    lName.content = params[:LName]
    customerName << lName

    customer << customerName

    telNo = Nokogiri::XML::Node.new("TelNo", doc)
    telNo.content = params[:TelNo]
    customer << telNo

    mail = Nokogiri::XML::Node.new("Mail", doc)
    mail.content = params[:Mail]
    customer << mail

    fullAddress = Nokogiri::XML::Node.new("FullAddress", doc)

    country = Nokogiri::XML::Node.new("Country", doc)
    country.content = params[:Country]
    fullAddress << country

    state = Nokogiri::XML::Node.new("State", doc)
    state.content = params[:State]
    fullAddress << state

    city = Nokogiri::XML::Node.new("City", doc)
    city.content = params[:City]
    fullAddress << city

    zip = Nokogiri::XML::Node.new("Zip", doc)
    zip.content = params[:Zip]
    fullAddress << zip

    address = Nokogiri::XML::Node.new("Address", doc)
    address.content = params[:Address]
    fullAddress << address

    customer << fullAddress

    company = Nokogiri::XML::Node.new("Company", doc)

    companyName = Nokogiri::XML::Node.new("CompanyName", doc)
    companyName.content = params[:CompanyName]
    company << companyName

    taxNo = Nokogiri::XML::Node.new("TaxNo", doc)
    taxNo.content = params[:TaxNo]
    company << taxNo

    customer << company

    order.add_child(customer.to_xml + "\n")
    # new_entry.add_child(para.to_xml + "\n")
    #doc.root.add_child(event.to_xml + "\n")
    doc = doc.to_xml
    File.write(orders, doc)
    redirect_back(fallback_location: root_path)
  end

  def eventDel
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    doc.xpath("//Event[@uuid='" + params[:uuid] + "']")[0].remove
    doc = doc.to_xml
    File.write(orders, doc)
    redirect_back(fallback_location: root_path)
  end

  def customerDel
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    doc.xpath("//Customer[@uuid='" + params[:uuid] + "']")[0].remove
    doc = doc.to_xml
    File.write(orders, doc)
    redirect_back(fallback_location: root_path)
  end

end
