class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:eventAdd, :customerAdd, :pay, :info]

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

    p = params[:id].to_s
    @out = xslt.transform(doc, ['key', p]) #, 'main_phone', params[:phone]])
  end

  def orders
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    admin_show_orders = File.join(Rails.root, 'app', 'assets', 'data', 'admin_show_orders.xsl')

    doc = Nokogiri::XML(File.read(orders))
    xslt = Nokogiri::XSLT(File.read(admin_show_orders))

    @out = xslt.transform(doc)
  end

  def eventsSort
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    admin_show_events_sorting = File.join(Rails.root, 'app', 'assets', 'data', 'admin_show_events_sorting.xsl')

    doc = Nokogiri::XML(File.read(orders))
    xslt = Nokogiri::XSLT(File.read(admin_show_events_sorting))

    @out = xslt.transform(doc)
  end

  def info
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    property = doc.xpath('//Order[@Key=' + params[:id] + ']/Information')[0]
    property.content = params[:information]
    doc = doc.to_xml
    File.write(orders, doc)
  end

  def pay
    orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
    doc = Nokogiri::XML(File.read(orders))
    propCost = doc.xpath("//Order[@Key=" + params[:id] + "]/Cost")[0]
    propCost.xpath("FullCost")[0].content = params[:FullCost]
    propCost.xpath("Prepayment")[0].content = params[:Prepayment]

    if(params[:Invoice]=="on")
      propCost.xpath("Invoice")[0].content = 'TAK'
    else
      propCost.xpath("Invoice")[0].content = 'NIE'
    end

    if(params[:Currency]=="PLN")
      propCost['Currency'] = 'PLN'
    elsif(params[:Currency]=="USD")
      propCost['Currency'] = 'USD'
    else
      propCost['Currency'] = 'EUR'
    end
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
    if(order.nil?)
      order = Nokogiri::XML::Node.new("Order", doc)
      order['Key'] = params[:id]

      information = Nokogiri::XML::Node.new("Information", doc)
      order << information

      cost = Nokogiri::XML::Node.new("Cost", doc)
      cost['Currency'] = "PLN"

      fullCost = Nokogiri::XML::Node.new("FullCost", doc)
      cost << fullCost

      prepayment = Nokogiri::XML::Node.new("Prepayment", doc)
      cost << prepayment

      invoice = Nokogiri::XML::Node.new("Invoice", doc)
      cost << invoice

      order << cost

      o = doc.xpath("Orders")[0]
      o.add_child(order.to_xml + "\n")
      doc = doc.to_xml
      File.write(orders, doc)

      orders = File.join(Rails.root, 'app', 'assets', 'data', 'orders.xml')
      doc = Nokogiri::XML(File.read(orders))
      doc.to_xml

      order = doc.xpath("//Order[@Key=" + params[:id] + "]")[0]
    end

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

    _order = doc.xpath('//Order[@Key=' + params[:id] + ']')[0]
    if(_order.nil?)
      _order = Nokogiri::XML::Node.new('Order', doc)
      _order['Key'] = params[:id]

      _information = Nokogiri::XML::Node.new('Information', doc)
      _order << _information

      _cost = Nokogiri::XML::Node.new('Cost', doc)
      _cost['Currency'] = 'PLN'

      _full_cost = Nokogiri::XML::Node.new('FullCost', doc)
      _cost << _full_cost

      _prepayment = Nokogiri::XML::Node.new('Prepayment', doc)
      _cost << _prepayment

      invoice = Nokogiri::XML::Node.new('Invoice', doc)
      _cost << invoice

      _order << _cost

      _o = doc.xpath('Orders')[0]
      _o.add_child(_order.to_xml + "\n")
      doc = doc.to_xml
      File.write(orders, doc)
      doc = Nokogiri::XML(File.read(orders))
      doc.to_xml

      _order = doc.xpath('//Order[@Key=' + params[:id] + ']')[0]
    end

    _customer = Nokogiri::XML::Node.new'Customer', doc
    _customer['uuid'] = SecureRandom.uuid

    _customer_name = Nokogiri::XML::Node.new('CustomerName', doc)

    _f_name = Nokogiri::XML::Node.new('FName', doc)
    _f_name.content = params[:FName]
    _customer_name << _f_name

    _l_name = Nokogiri::XML::Node.new('LName', doc)
    _l_name.content = params[:LName]
    _customer_name << _l_name

    _customer << _customer_name

    _tel_no = Nokogiri::XML::Node.new('TelNo', doc)
    _tel_no.content = params[:TelNo]
    _customer << _tel_no

    _mail = Nokogiri::XML::Node.new('Mail', doc)
    _mail.content = params[:Mail]
    _customer << _mail

    _full_address = Nokogiri::XML::Node.new('FullAddress', doc)

    country = Nokogiri::XML::Node.new('Country', doc)
    country.content = params[:Country]
    _full_address << country

    state = Nokogiri::XML::Node.new('State', doc)
    state.content = params[:State]
    _full_address << state

    city = Nokogiri::XML::Node.new('City', doc)
    city.content = params[:City]
    _full_address << city

    zip = Nokogiri::XML::Node.new('Zip', doc)
    zip.content = params[:Zip]
    _full_address << zip

    address = Nokogiri::XML::Node.new('Address', doc)
    address.content = params[:Address]
    _full_address << address

    _customer << _full_address

    _company = Nokogiri::XML::Node.new('Company', doc)

    _company_name = Nokogiri::XML::Node.new('CompanyName', doc)
    _company_name.content = params[:CompanyName]
    _company << _company_name

    _tax_no = Nokogiri::XML::Node.new('TaxNo', doc)
    _tax_no.content = params[:TaxNo]
    _company << _tax_no

    _customer << _company

    _order.add_child(_customer.to_xml + "\n")
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
