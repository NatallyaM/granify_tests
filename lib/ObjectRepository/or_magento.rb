require_relative 'or_granify'
require_relative 'or_base'

class MagentoAdminPage < BasePage
   
  def login_username_textfield
    return @browser.find_element(:id, "username")
  end
  
  def login_password_textfield
    return @browser.find_element(:id, "login")
  end
  
  def login_button
    return @browser.find_element(:css, "html body#page-login div.login-container div.login-box form#loginForm div.login-form div.form-buttons input.form-button")
  end
  
  def system_dropdown
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[10]/a/span")
  end
  
  def promotions_dropdown
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[6]/a/span")
  end
  
  def shopping_cart_rules_item
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[6]/ul/li[2]/a/span")
  end
  
  def add_new_rule_button
      @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Add New Rule"
      end      
  end
  def save_rule_button
      @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Save Rule"
      end      
  end
  
  def save_rule_continue_button
      @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Save and Continue Edit"
      end      
  end
  
  def magento_connect_menuitem
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[10]/ul/li[14]/a/span")
  end                                     
  
  def magento_cache_management_menuitem
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[10]/ul/li[15]/a/span")
  end
  
  def magento_connect_manager_menuitem
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[10]/ul/li[14]/ul/li/a/span")
  end                                     
  def magento_configuration_menuitem
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/ul/li[10]/ul/li[19]/a/span")
  end
  def configuration_scope_dropdown
    return @browser.find_element(:id, "store_switcher")
  end
  def granify_tab
    return @browser.find_element(:xpath, "/html/body/div/div[2]/div/div/div/ul/li[6]/dl/dd[2]/a/span")
  end
  def site_id_textfield
    return @browser.find_element(:id, "granify_general_site_id")
  end
  def api_secret_textfield
    return @browser.find_element(:id, "granify_general_api_secret")
  end
  def secondary_login_textfield
    return @browser.find_element(:id, "username")
  end
  def secondary_password_textfield
    return @browser.find_element(:id, "password")
  end
  def secondary_login_button
    return @browser.find_element(:css, "html body div.container div.main div.content div form table.form-list tbody tr td.value button")
  end
  
  def select_file
    return @browser.find_element(:id, "file")
  end
  
  def maintenance_checkbox
    return @browser.find_element(:id, "maintenance")
  end
  def plugin_upload_button
    return @browser.find_element(:xpath, "/html/body/div/div[2]/div[2]/form[2]/ul/li[2]/button")
  end
  
  def success_message
    return @browser.find_element(:class, "success-msg")
  end
  
  def plugin_commit_button
    return @browser.find_element(:xpath, "/html/body/div/div[2]/div[2]/form[3]/p/button")
  end
  
  def plugin_clearcache_checkbox
    @browser.find_element(:id, "clean_sessions")
  end
  
  def flush_magento_cache_button
      @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Flush Magento Cache"
      end
      
  end
  
  def flush_cache_storage_button
          @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Flush Cache Storage"
      end
  end
  
  def rule_name_textfield
    return @browser.find_element(:id, "rule_name")
  end
  
  def customer_group_select
    return @browser.find_element(:id, "rule_customer_group_ids")
  end
  def website_select
    return @browser.find_element(:id, "rule_website_ids")
  end
  def coupon_select_dropdown
    return @browser.find_element(:id, "rule_coupon_type")
  end
  
  def coupon_code_textfield
    return @browser.find_element(:id, "rule_coupon_code")
  end
  
  def actions_tab_link
    return @browser.find_element(:id, "promo_catalog_edit_tabs_actions_section")
  end
  
  def discount_amount_textfield
    return @browser.find_element(:id, "rule_discount_amount")
  end
  
  
  def search_by_order_textfield
    return @browser.find_element(:id, "filter_real_order_id")
  end
  
  def global_search_textfield
    return @browser.find_element(:id, "global_search")
  end
  
  def global_search_autocomplete
    return @browser.find_element(:xpath, "global_search_autocomplete")
  end
  
  def search_button
    @browser.find_element(:xpath, "//*[@id=\"id_9cf4184c68cb51bc0dd1e20acf7aa990\"]")
  end
  
  def first_order_row
    @browser.find_element(:xpath, "/html/body/div/div[2]/div/div[3]/div/div[2]/div/table/tbody/tr")
  end
  
  def invoice_button
    @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Invoice"
      end
  end
  
  def create_shipment_checkbox
    @browser.find_element(:id, "invoice_do_shipment")
  end
  
  def submit_invoice_button
      @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Submit Invoice"
      end
  end
  def plugin_actions_dropdown
    return @browser.find_element(:xpath, "/html/body/div/div[2]/div[2]/form[3]/table/tbody/tr/td[3]/select")
  end
  
  #Magento helpers
  def _magento_admin_login
    @wait.until {self.login_username_textfield}
    self.login_username_textfield.send_keys("#{$magento_admin_username}")
    self.login_password_textfield.send_keys("#{$magento_admin_password}")
    self.login_button.submit
  end
  
  def _magento_goto_connectmanager
    @wait.until {self.system_dropdown}
    self.system_dropdown.click
    self.magento_connect_menuitem.click
    @wait.until {self.magento_connect_manager_menuitem}
    self.magento_connect_manager_menuitem.click
  end
  
  def _magento_admin_secondary_login
    @wait.until {self.secondary_login_textfield}
    self.secondary_login_textfield.send_keys("#{$magento_admin_username}")
    self.secondary_password_textfield.send_keys("#{$magento_admin_password}")
    self.secondary_login_button.submit
  end
  
  def _magento_granify_plugin_upload
    @wait.until {self.select_file}
    
    #Unchecking maintenance checkbox
    if maintenance_checkbox.selected?
      maintenance_checkbox.click
    end
    
    #setting plugin path
    @directory = Dir.getwd
    self.select_file.send_keys("#{@directory}/lib/granify_plugin-1.0.20.tgz")
#    @directory = Dir.getwd.gsub!('/', '\\')
#    self.select_file.send_keys("#{@directory}\\lib\\granify_plugin-1.0.20.tgz")

    #confirming action
    self.plugin_upload_button.submit
    
    begin
      @wait.until {self.success_message}
      rescue
        return false
    end
    return true
  end
  def _magento_multiple_storeview_check()
    #go to system - configuration. Open Granify tab
    @wait.until {self.system_dropdown}
    self.system_dropdown.click
    @wait.until {self.magento_configuration_menuitem}
    self.magento_configuration_menuitem.click
    begin
      @wait.until {self.granify_tab}
      self.granify_tab.click
    rescue
      return false
    end
    
    #check if site ID/API Secret exists for selected store view
    @wait.until {self.configuration_scope_dropdown}
    self.configuration_scope_dropdown.find_elements(:tag_name => "option").find do |option|
     option.text.include? "Second Website Store View 2"
    end.click    
    sleep 2
    @wait.until {self.site_id_textfield}
    sleep 2
    if self.site_id_textfield.attribute("value") == "" || self.api_secret_textfield.attribute("value") == ""
      return false
    end
    
    #check if site ID/API Secret absent for others store views
    self.configuration_scope_dropdown.find_elements(:tag_name => "option").find do |option|
     option.text.include? "Second Website Store View 1"
    end.click    
    sleep 2
    if self.site_id_textfield.attribute("value") != "" || self.api_secret_textfield.attribute("value") != ""
      return false
    end
    self.configuration_scope_dropdown.find_elements(:tag_name => "option").find do |option|
     option.text.include? "Default Store View"
    end.click    
    sleep 2
    @wait.until {self.site_id_textfield}
    sleep 2
    if self.site_id_textfield.attribute("value") != "" || self.api_secret_textfield.attribute("value") != ""
      return false
    end
    return true  
  end
  def _magento_granify_plugin_uninstall()
    @wait.until {self.plugin_actions_dropdown}
    
    #Unchecking maintenance checkbox
    if maintenance_checkbox.selected?
      maintenance_checkbox.click
    end
    
    self.plugin_actions_dropdown.find_elements(:tag_name => "option").find do |option|
      option.text == "Uninstall"
    end.click
    self.plugin_commit_button.click    
   begin
      @wait.until {self.success_message}
    rescue
      return false
    end
    return true
  end
  
  def _magento_granify_plugin_commit
    @wait.until {self.plugin_commit_button}
    self.plugin_clearcache_checkbox.click
    self.plugin_commit_button.submit
    
    #to add verification if commited succesfully
    
  end
  
  def _magento_cache_flush
    @wait.until {self.system_dropdown}
    self.system_dropdown.click
    @wait.until {magento_cache_management_menuitem}
    self.magento_cache_management_menuitem.click
    @wait.until {self.flush_cache_storage_button}
    self.flush_magento_cache_button.click
    begin
      @wait.until {self.success_message}
      rescue
        return false
    end
    @browser.navigate.refresh
    self.flush_cache_storage_button.click
    alert = @browser.switch_to.alert
    alert.accept
    begin
      @wait.until {self.success_message}
      rescue
        return false
    end
    return true
  end
    
  def _magento_offer_create()
    @wait.until {self.promotions_dropdown}
    self.promotions_dropdown.click
    self.shopping_cart_rules_item.click
    @wait.until {self.add_new_rule_button}
    self.add_new_rule_button.click
    @wait.until {self.rule_name_textfield}
    self.rule_name_textfield.send_keys("Coupon #{$coupon}")
    self.customer_group_select.find_elements(:tag_name => "option").find do |options|
      options.text == "NOT LOGGED IN"
      end.click
    self.website_select.find_elements(:tag_name => "option").find do |options|
      options.text == "Main Website"
    end.click
    self.coupon_select_dropdown.find_elements(:tag_name => "option").find do |option|
      option.text == "Specific Coupon"
    end.click
    self.coupon_code_textfield.send_keys("#{$coupon}")
    self.save_rule_continue_button.click()
    begin
      @wait.until {self.success_message}
    rescue
      return false
    end
    self.actions_tab_link.click
    @wait.until {self.discount_amount_textfield}
    self.discount_amount_textfield.send_keys("10")
    self.save_rule_button.click()
    begin
      @wait.until {self.add_new_rule_button}
    rescue
      return false
    end
    return true
  end
  
    def _magento_order_confirm()
      @wait.until {self.global_search_textfield}
#      self.global_search_textfield.send_keys("#{$magento_order_id}")
#      sleep 5
#      @wait.until {self.global_search_autocomplete}
#      self.global_search_autocomplete.click
      oid = $magento_order_id[1..-1]
      @browser.get("#{$magento_store_default_link}admin/sales_order/view/order_id/#{oid}/")
      
      @wait.until {self.invoice_button}
      self.invoice_button.click
      @wait.until {self.create_shipment_checkbox}
      self.create_shipment_checkbox.click
      self.submit_invoice_button.click
      begin
        @wait.until {self.success_message}
      rescue
        return false
      end
      return true
    end
    
end

class MagentoShopPage < BasePage
  
 
  def add_to_cart_button
    return @browser.find_element(:xpath, "/html/body/div/div/div[3]/div/div[2]/form/div[2]/div/div[2]/div/button")
  end
  
  def discount_codes_textfield
    return @browser.find_element(:id, "coupon_code")
  end
  
  def grand_total_string
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/div/div[2]/table/tfoot/tr/td[2]/strong/span")
  end
  
  def apply_coupon_button
    @browser.find_elements(:tag_name => "button").find do |option|
        option.text.include? "Apply Coupon"
      end   
  end
  def success_message
    return @browser.find_element(:class, "success-msg")
  end
  
  def proceed_to_checkout_button
    return @browser.find_element(:css, "html body.checkout-cart-index div.wrapper div.page div.main div.col-main div.cart div.totals ul.checkout-types li button.button")
  end
  
  def guest_checkout_radiobutton
    return @browser.find_element(:id, "login:guest")
  end
  
  def continue_button
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/div/ol/li/div[2]/div/div[2]/div/button")
  end
  
  def first_name_textfield
    return @browser.find_element(:id, "billing:firstname")
  end
  
  def last_name_textfield
    return @browser.find_element(:id, "billing:lastname")
  end
  
  def email_textfield
    return @browser.find_element(:id, "billing:email")
  end
  
  def address_textfield
    return @browser.find_element(:id, "billing:street1")
  end
  
  def city_textfield
    return @browser.find_element(:id, "billing:city")
  end
  
  def zipcode_textfield
    return @browser.find_element(:id, "billing:postcode")
  end
  
  def country_textfield
    return @browser.find_element(:id, "billing:country_id")
  end
  
  def telephone_textfield
    return @browser.find_element(:id, "billing:telephone")
  end
  
  def ship_to_this_address_radiobutton
    return @browser.find_element(:id, "billing:use_for_shipping_yes")
  end
  
  def checkout_continue_button
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/div/ol/li[2]/div[2]/form/div/button")
  end
  def checkout_continue1_button
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/div/ol/li[4]/div[2]/form/div[3]/button")
  end
  def checkout_continue2_button
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/div/ol/li[5]/div[2]/div[2]/button")
  end
  
  def check_money_order_radiobutton
    return @browser.find_element(:id, "p_method_checkmo")
  end
  
  def place_order_button
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/div/ol/li[6]/div[2]/div/div[2]/div/button")
  end
  def order_confirm_message
    return @browser.find_element(:xpath, "/html/body/div/div/div[2]/div/p")
  end
  def continue_shopping_button
    return @browser.find_element(:css, "html body.checkout-onepage-success div.wrapper div.page div.main div.col-main div.buttons-set button.button")
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
       puts 'First return'
       return false         
     end      
   end
      sleep 3
      str = offer.text
      if (str.include? "Autotest offer") && (str.include? "10 per-cent test discount") && (str.include? "#{$coupon}")
        return true
      else
        puts 'Second return'
        return false 
      end  
  end

  
  def _magento_plugin_sourcecode_verify
    source = @browser.page_source.to_s
    if source.index("window.Granify =") == nil
      return false
    else
      return true      
    end
  end
  
  def _magento_order_submit
    begin
      sleep 5
      @wait.until {self.offer_slider_div}
      self.slider_hide_button.click
    rescue
    end
    begin
      @wait.until {self.modal_ok_button}
      self.modal_ok_button.click
    rescue
   end
    @wait.until {self.add_to_cart_button}
    self.add_to_cart_button.click
    @wait.until {self.discount_codes_textfield}
    @browser.navigate.refresh
    self.discount_codes_textfield.send_keys("#{$coupon}")
    self.discount_codes_textfield.submit
    begin
      @wait.until {self.success_message}
    rescue
      return false
    end
    if self.grand_total_string.text != "$90.00"
      puts self.grand_total_string.text
      return false
    end
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    self.proceed_to_checkout_button.click
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    @wait.until {self.guest_checkout_radiobutton}
    self.guest_checkout_radiobutton.click
    @wait.until {self.continue_button}
    self.continue_button.click
    begin
      self.modal_ok_button.click() if self.modal_ok_button != nil
    rescue
    end
    @wait.until {self.first_name_textfield}
    self.first_name_textfield.send_keys("Test1")
    self.last_name_textfield.send_keys("Test2")
    self.email_textfield.send_keys("Test@test.com")
    self.address_textfield.send_keys("Test Address 1")
    self.city_textfield.send_keys("Test City")
    self.country_textfield.find_elements(:tag_name => "option").find do |option|
      option.text == "Albania"
    end.click
    self.zipcode_textfield.send_keys("11111")
    self.telephone_textfield.send_keys("12345678")
    self.checkout_continue_button.click()
    @wait.until {self.checkout_continue1_button}
    sleep 3
    self.checkout_continue1_button.click()
    @wait.until {self.check_money_order_radiobutton}
    sleep 3
    self.check_money_order_radiobutton.click
    self.checkout_continue2_button.click()
    sleep 3
    @wait.until {self.place_order_button}
    self.place_order_button.click()
    begin
      @wait.until {self.continue_shopping_button}
    rescue
      return false
    end
    if !self.order_confirm_message.text.include? "Your order # is"
      return false
    end
    $magento_order_id = self.order_confirm_message.text.sub(/^Your order # is: /, '').chomp('.')
    return true
  end
  

  
  
end
