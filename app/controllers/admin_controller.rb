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
end
