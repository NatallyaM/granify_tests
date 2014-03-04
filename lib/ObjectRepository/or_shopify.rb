require_relative 'or_base'
require_relative 'or_granify'
class ShopifyLoginPage < BasePage
  
  def email_textfiled
    return @browser.find_element(:id, "login-input")
  end
  
  def password_textfield
    return @browser.find_element(:id, "password")
  end
  
  def login_button
    return @browser.find_element(:name, "commit")
  end
  

  def _shopify_login()
    @wait.until {self.email_textfiled}
    self.email_textfiled.send_keys("#{$shopify_admin_username}")
    self.password_textfield.send_keys("#{$shopify_admin_password}")
    self.login_button.submit
  end  
  
end

class ShopifyAdminArea < BasePage
  
  def install_app_button
    return @browser.find_element(:name, "commit")
  end
  
  def discounts_link
    return @browser.find_element(:link_text, "Discounts")
  end
  
  def add_discount_button
    return @browser.find_element(:link_text, "Add discount")
  end
  
  def discount_code_textfield
    return @browser.find_element(:id, "coupon-code")
  end
  
  def discount_type_dropdown
    return @browser.find_element(:id, "coupon-type")
  end
  
  def discount_value_textfield
    return @browser.find_element(:id, "discount-value")
  end
  
  def discount_save_button
    return @browser.find_element(:css, "html.no-js body#body-content.windows div#wrapper.wrapper div#body.clearfix div#content section#undefined div div#promotions-new.page form div.section input.btn")
  end
  
  def no_discounts_found
    return @browser.find_element(:id, "dblank-slate")
  end
  
  def discount_search_filter
    return @browser.find_element(:css, "html.no-js body#body-content.windows div#wrapper.wrapper div#body.clearfix div#content section#undefined div div#pages-index.page div.row div div.obj-filter div.variable-container form input.obj-filter-text")
  end
  
  def apps_link
    return @browser.find_element(:partial_link_text, "Apps")
  end
  
  def granify_staging_link
    return @browser.find_element(:partial_link_text, "Granify staging")
  end
  
  def options_dropdown
    return @browser.find_element(:xpath, "/html/body/div[5]/div/div[2]/section/div/div/div[4]/div[2]/div/div/div[2]/ul/li/a")
  end
  
  def granify_remove_link
    return @browser.find_element(:partial_link_text, "Remove this app")
  end
  
  def granify_remove_confirm_button
    return @browser.find_element(:css, ".btn.btn-destroy-no-hover")
  end
  # shopify admin area helpers
  def _granify_plugin_uninstall
    @wait.until {self.apps_link}
    self.apps_link.click()
    @wait.until {self.options_dropdown}
    self.options_dropdown.click()
    @wait.until {self.granify_remove_link}
    self.granify_remove_link.click()
    @wait.until {self.granify_remove_confirm_button} 
    self.granify_remove_confirm_button.click()
    sleep 5
    @active_window.close
  end
  
  def _discount_create #creating test discount in shopify admin area
    @wait.until {self.discounts_link}
    self.discounts_link.click()
    sleep 5
    @wait.until {self.add_discount_button}
    self.add_discount_button.click()
    @wait.until {self.discount_code_textfield}
    sleep 3 #to check how we could verify if form loaded
    self.discount_code_textfield.send_keys "#{$coupon}"
    self.discount_type_dropdown.find_elements(:tag_name => "option").find do |option|
            option.text == "% Discount"
    end.click
    @wait.until {self.discount_value_textfield}
    self.discount_value_textfield.send_keys "10"
    self.discount_value_textfield.submit()
    begin
      @wait.until {@browser.find_element(:id, "discount-table")}
#      sleep 5
#      self.discount_search_filter.send_keys "#{$coupon}"
#      begin
#        @wait.until {self.no_discounts_found}
#      rescue
#        return true
#      else
#        return false
#      end
    rescue
      return false
    end
  end
  
end

class ShopifyShopPage < BasePage
  
  def add_to_cart_button
    return @browser.find_element(:id, "add-to-cart")
  end
  
  def view_cart_link
    return @browser.find_element(:partial_link_text, "View cart and check out")
  end
  
  def proceed_to_checkout_button
    return @browser.find_element(:css, "html.js body.templateCart div.wrapper div.content-wrapper div#col-main.full form#cartform.clearfix div#checkout-proceed input#update-cart.btn-reversed")
  end
  
  def order_email_textfield
    return @browser.find_element(:id, "order_email")
  end
  
  def order_firstname_textfield
    return @browser.find_element(:id, "billing_address_first_name")
  end
  
  def order_lastname_textfield
    return @browser.find_element(:id, "billing_address_last_name")
  end
  
  def order_address_textfield
    return @browser.find_element(:id, "billing_address_address1")
  end
  
  def order_city_textfield
    return @browser.find_element(:id, "billing_address_city")
  end
  
  def order_country_dropdown
    return @browser.find_element(:id, "billing_address_country")
  end
  
  def order_zipcode_textfield
    return @browser.find_element(:id, "billing_address_zip")
  end
  
  def order_continue_button
    return @browser.find_element(:id, "commit-button")
  end
  
  def discount_code_textfield
    return @browser.find_element(:id, "discount_code")
  end
  
  def discount_apply_button
    return @browser.find_element(:css, "html body div#container.step2 div#main div#content div#discounts div.group form#new_discount.new_discount div#discounts-body input")
  end
  
  def order_amount_span
    return @browser.find_element(:id, "cost")
  end
  
  def credit_card_textfield
    return @browser.find_element(:id, "credit_card_number")
  end
  
  def credit_card_security_textfield
    return @browser.find_element(:id, "credit_card_verification_value")
  end
  
  def complete_purchase_button
    return @browser.find_element(:id, "complete-purchase")
  end
  
  def credit_card_year_dropdown
    return @browser.find_element(:id, "credit_card_year")
  end
  
  def orderid_value
    return @browser.find_element(:css, "html body div#container.slim div#main div#content div.group p strong")
  end
  
  def content_purchase_div
    return @browser.find_element(:id, "content")
  end
  
  def offer_slider_div
    return @browser.find_element(:id, "granify-coupon")
  end
  
  def offer_modal_div
    return @browser.find_element(:id, "granify-modal")
  end
  
  def modal_ok_button
     return @browser.find_element(:link_text, "OK")
  end
  
  def slider_hide_button
    return @browser.find_element(:id, "gc-tab")
  end
  
  def _offer_verify()
    begin
      @wait.until {self.offer_slider_div}
      offer = self.offer_slider_div
    rescue
      begin
        @wait.until {self.offer_modal_div}
        offer = self.offer_modal_div
      rescue
        return false         
      end      
    end
      str = offer.text
      if (str.include? "Autotest offer") && (str.include? "10 per-cent test discount") && (str.include? "#{$coupon}")
        return true
      else
        return false        
      end  
  end

  
  def _shopify_plugin_sourcecode_verify()
    source = @browser.page_source.to_s
    if source.index("granify") == nil
      return false
    else
      return true      
    end
  end
  
  def _shopify_purchase()
   begin
      sleep 5
      @wait.until {self.offer_slider_div}
      self.slider_hide_button.click
    rescue
    end
    @wait.until {self.add_to_cart_button}
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    self.add_to_cart_button.click()
    
    @wait.until {self.view_cart_link}
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    self.view_cart_link.click()
    
    @wait.until {self.proceed_to_checkout_button}
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    sleep 5
    self.proceed_to_checkout_button.click()
    
    @wait.until {self.order_email_textfield}
    if (!self.order_amount_span.text.include? "$100.00")
      return false
    end
    self.order_email_textfield.send_keys("test@test.com")
    self.order_firstname_textfield.send_keys("test")
    self.order_lastname_textfield.send_keys("test")
    self.order_address_textfield.send_keys("test")
    self.order_city_textfield.send_keys("test")
    self.order_zipcode_textfield.send_keys("1111")
    self.order_country_dropdown.find_elements(:tag_name => "option").find do |option|
         option.text == "Bermuda"
    end.click
    self.order_continue_button.click()
    
    begin
      @wait.until {self.order_amount_span.text.include? "$100.00"}
      rescue
        return false
    end
    self.discount_code_textfield.send_keys("#{$coupon}")
    self.discount_apply_button.submit()
    begin
      @wait.until {self.order_amount_span.text.include? "$90.00"}
    rescue
      return false
    end
    self.credit_card_textfield.send_keys("1")
    self.credit_card_security_textfield.send_keys("111")
    self.credit_card_year_dropdown.find_elements(:tag_name => "option").find do |option|
         option.text == "2020"
    end.click
    self.complete_purchase_button.submit()
    
    begin
      @wait.until {self.content_purchase_div.text.include? "Your Order ID is"}
    rescue
      return false
    end
    $shopify_order_id = self.orderid_value.text[1..-1]
    return true
  end
  
end
