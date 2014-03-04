require_relative 'or_base'

class GranifyRegisterPage < BasePage
   
  def name_textfield 
    return @browser.find_element(:id, "user_name")    
  end
  
  def email_textfield 
    return @browser.find_element(:id, "user_email")    
  end
  
  def phone_textfield 
    return @browser.find_element(:id, "user_phone")    
  end
  
  def password_textfield
    return @browser.find_element(:id, "user_password")
  end
        
  def password_confirmation_textfield
    return @browser.find_element(:id, "user_password_confirmation")
  end
  
  def store_url_textfield
    return @browser.find_element(:id, "user_company_attributes_sites_attributes_0_url")
  end
  
  def store_type_dropdown
    return @browser.find_element(:id, "user_company_attributes_sites_attributes_0_shop_type")
  end
  
  def submit_button
    return @browser.find_element(:css, ".btn.btn-primary.btn-large")
  end
  
  #Helpers for Granify Register page
  def _register_random(shop_type = "magento")
    #Generating mock data for registration form
    @random = (0...8).map{65.+(rand(25)).chr}.join.downcase
    $granify_mock_user = @random
    @granify_mock_email = @random+"@"+@random+".com"
    case shop_type
    when "magento"
      @shop_type = "Magento"
    when "shopify"
      @shop_type = "Shopify"
    end
    
    # random email/name/any valid URL can be used, you need to select the “magento” shop type
    @wait.until {self.name_textfield}
    self.name_textfield.send_keys ($granify_mock_user)
    self.email_textfield.send_keys (@granify_mock_email)
    self.phone_textfield.send_keys ("1234567")
    self.password_textfield.send_keys ("Password1")
    self.password_confirmation_textfield.send_keys ("Password1")
    self.store_url_textfield.send_keys ("#{@random}.ukr.net")
    @wait.until {self.store_type_dropdown}
    self.store_type_dropdown.find_elements(:tag_name => "option").find do |option|
      option.text == "#{@shop_type}"
    end.click
    self.submit_button.submit
  end
  
  def _register(username = $granify_magento_user_name, password = $granify_magento_user_password, email = $granify_magento_user_email, 
    phone = $granify_user_phone_number, url = $magento_store_default_link, shop_type = "magento")
    @username = username
    @email = email 
    @password = password
    @phone = phone   
    @url = url
   
    case shop_type
    when "magento"
      @shop_type = "Magento"
    when "shopify"
      @shop_type = "Shopify"
    end
    
    #wait till the last element on the page
    @wait.until {self.store_type_dropdown}
#   @wait.until {self.name_textfield}
    self.name_textfield.send_keys (@username)
    self.email_textfield.send_keys (@email)
    self.phone_textfield.send_keys ("1234567")
    self.password_textfield.send_keys (@password)
    self.password_confirmation_textfield.send_keys (@password)
    self.store_url_textfield.send_keys (@url)   
    self.store_type_dropdown.find_elements(:tag_name => "option").find do |option|
      option.text == "#{@shop_type}"
    end.click
    self.submit_button.submit
  end
end

class GranifyMemberArea < BasePage
    
  def user_account_menu_dropdown
    return @browser.find_element(:css, "html.wf-proximanova-n8-active body.default div.navbar div.navbar-inner div.container-fluid ul.main-app-nav li.dropdown a.dropdown-toggle")
  end
  def admin_account_menu_dropdown
    return @browser.find_element(:xpath, "/html/body/div/div/div/ul[2]/li/a")
  end
  
  def signout_menuitem
    return @browser.find_element(:partial_link_text, "Sign out")
  end
  
  def test_dropdown
     @browser.find_elements(:class => "dropdown-toggle").find do |option|
        option.text.include? "Test"
     end
  end
  
  def users_menuitem
    return @browser.find_element(:partial_link_text, "Users")
  end
  def companies_menuitem
    return @browser.find_element(:partial_link_text, "Companies")
  end
  def stores_menuitem
    return @browser.find_element(:partial_link_text, "Stores")
  end
  def search_textfield
    return @browser.find_element(:xpath, "//*[@id=\"DataTables_Table_0_filter\"]/label/input")
  end                                     
  
  def result_user(username)
    return @browser.find_element(:partial_link_text, "#{username}")
  end
  
  def id_cell
    return @browser.find_element(:class, "  sorting_1")
  end
  
  def users_actions_dropdown
    return @browser.find_element(:xpath, "/html/body/div[2]/div/div/table/tbody/tr[1]/td[8]/div/a")
  end
  def companies_actions_dropdown
    return @browser.find_element(:xpath, "/html/body/div[2]/div/div/form/div[2]/table/tbody/tr[1]/td[7]/div/a/span")
  end
  def destroy_menuitem_companies
    return @browser.find_element(:partial_link_text, "Delete")
  end
    def destroy_menuitem_users
    return @browser.find_element(:partial_link_text, "Destroy")
  end
  def show_menuitem
    return @browser.find_element(:partial_link_text, "Show")
  end
  def edit_button
    return @browser.find_element(:partial_link_text, "Edit")
  end
  def isenterprise_checkbox
    return @browser.find_element(:id, "company_is_enterprise")
  end
  def updatecompany_button
    return @browser.find_element(:name, "commit")
  end
  def empty_table_results
    return @browser.find_element(:class, "dataTables_empty")
  end
  
  
  def install_link
    return @browser.find_element(:link_text, "install Granify")
  end  
  
  def install_link
    return @browser.find_element(:link_text, "install Granify")
  end  
  
  def download_plugin_button
    return @browser.find_element(:link_text, "Download Granify plugin for Magento")
  end
  def plugin_installation_next_step_button
    return @browser.find_element(:link_text, "Next step")
  end
  def plugin_installation_confirm_button
    return @browser.find_element(:link_text, "Okay, I've installed the plugin!")
  end
  def success_installation_messagebox
    return @browser.find_element(:class, "collecting-data-banner")
  end
  def select_store_dropdown
    return @browser.find_element(:tag_name, "select")
  end
  def finish_installation_button
    form = @browser.find_element(:class, "form-actions")
    button = form.find_element(:tag_name, "input")
    return button
  end

  def create_first_offer_button
    return @browser.find_element(:partial_link_text, "Create your first message")
  end
  
  def offer_type_dropdown
    return @browser.find_element(:id, "offer_campaign_type")
  end
  def headline_textfield
    return @browser.find_element(:id, "offer_outcome_headline")
  end
  def message_textfield
    return @browser.find_element(:id, "offer_outcome_text")
  end
  def coupon_code_textfield
    return @browser.find_element(:id, "offer_offer_coupon")
  end
  def coupon_value_textfield
    return @browser.find_element(:id, "offer_offer_value")
  end
  def offer_save_button
    return @browser.find_element(:name, "commit")
  end
  def offer_activate_checkbox
    return @browser.find_element(:id, "offer")
  end
  
  def continue_to_shopify_button
    return @browser.find_element(:partial_link_text, "Continue to Shopify")
  end
  
  def dashboard_visitors
    return @browser.find_element(:xpath, "/html/body/div[2]/div/div/table[2]/tbody/tr/td[2]")
  end                                     
  
  def dashboard_orders
    return @browser.find_element(:xpath, "/html/body/div[2]/div/div/table[2]/tbody/tr/td[3]/span")
  end                                     
  
  def dashboard_revenue
    return @browser.find_element(:xpath, "/html/body/div[2]/div/div/table[2]/tbody/tr/td[4]/span")
  end                                     
  
  def dashboard_revenue_to_visitors
     return @browser.find_element(:xpath, "/html/body/div[2]/div/div/table[2]/tbody/tr/td[5]")
  end                                       
  
  def dashboard_impressions
    return @browser.find_element(:xpath, "/html/body/div[2]/div/table/tbody/tr/td[3]")
  end                                     
  
  def dashboard_conversion
    return @browser.find_element(:xpath, "/html/body/div[2]/div/table/tbody/tr/td[4]")
  end
  
  def visits_row1
    return @browser.find_element(:xpath, "/html/body/div[2]/div/table/tbody/tr")    
  end
  def visits_row2
    return @browser.find_element(:xpath, "/html/body/div[2]/div/table/tbody/tr[2]")    
  end                                     
  
  def dashboard_link
    return @browser.find_element(:partial_link_text, "Dashboard")
  end
  
  def visits_link
    return @browser.find_element(:partial_link_text, "Visits")
  end
  
  def export_to_csv_button
    return @browser.find_element(:partial_link_text, "Export to CSV")
  end
  
  #Helpers for Granify Member Area page
  
  def _granify_user_logout
    @wait.until {self.user_account_menu_dropdown}
    self.user_account_menu_dropdown.click
    @wait.until {self.signout_menuitem}
    self.signout_menuitem.click
  end
  def _granify_admin_logout
    @wait.until {self.admin_account_menu_dropdown}
    self.admin_account_menu_dropdown.click
    @wait.until {self.signout_menuitem}
    self.signout_menuitem.click
  end
  
  def _granify_testuser_search(username)
    #go to test users list
    @wait.until {self.test_dropdown}
    self.test_dropdown.click
    self.users_menuitem.click
    @wait.until {self.search_textfield}
    
    #fill search field with username
    self.search_textfield.send_keys(username)

    #wait and verify search results. 
    begin
      @wait.until {self.result_user(username)}
    rescue
      return false
    else
      return true
    end
    return true
  end
  def _granify_get_store_id(store)
    #go to test users list
    @wait.until {self.test_dropdown}
    self.test_dropdown.click
    self.stores_menuitem.click
    @wait.until {self.search_textfield}
    
    #fill search field with username
    self.search_textfield.send_keys(store)

    #wait and verify search results. 
    begin
      @wait.until {self.result_user(store)}
    rescue
      return
    end    
    #get store id
    return id_cell.text
  end
  def _granify_user_destroy(username)
      self.users_actions_dropdown.click
      self.destroy_menuitem_users.click
      alert = @browser.switch_to.alert
      alert.accept
      
      #check if user was actually deleted
      @wait.until {self.test_dropdown}
      self.test_dropdown.click
      self.users_menuitem.click
      @wait.until {self.search_textfield}
      self.search_textfield.send_keys(username)
      begin
        @wait.until {self.result_user(username)}
      rescue
        return false
      end
      return true
    end
    
  def _granify_get_plugin_link
    @wait.until {self.install_link}
    self.install_link.click
    @wait.until {self.download_plugin_button} 
    $plugin_url = self.download_plugin_button.attribute("href")
  end
  
  def _granify_continue_to_shopify_link
    @wait.until {self.install_link}
    self.install_link.click
  end
  
   def _granify_continue_to_shopify_button
    @wait.until {self.install_link}
    self.install_link.click
  end 
  
  def _granify_magento_installation_confirm(store_view = "Default Store View")
#   begin
    @wait.until {self.install_link}
    self.install_link.click
    @wait.until {self.plugin_installation_next_step_button}    
    self.plugin_installation_next_step_button.click

    sleep 3

    @wait.until {self.plugin_installation_next_step_button}    
    self.plugin_installation_next_step_button.click

    sleep 3
    
    @wait.until {self.plugin_installation_next_step_button}    
    self.plugin_installation_next_step_button.click

    sleep 3
    
    @wait.until {self.plugin_installation_confirm_button}    
    self.plugin_installation_confirm_button.click
    @wait.until {self.finish_installation_button}
    self.select_store_dropdown.find_elements(:tag_name => "option").find do |option|
      option.text == store_view
    end.click
    self.finish_installation_button.submit
#    rescue
#      return false
#    end
#    return true
  end
    
  def _granify_installation_verify
    begin
      @wait.until {self.success_installation_messagebox}
    rescue
      return false
    else
      return true
    end
    return true
  end
  def _granify_set_company_enterprise(company)
    #go to test users list
    @wait.until {self.test_dropdown}
    self.test_dropdown.click
    self.companies_menuitem.click
    @wait.until {self.search_textfield}
    
    #fill search field with username
    self.search_textfield.send_keys(company)

    #wait and verify search results. 
    @wait.until {self.result_user(company)}
    self.companies_actions_dropdown.click
    self.show_menuitem.click
    @wait.until {self.edit_button}
    self.edit_button.click
    @wait.until {self.isenterprise_checkbox}
    self.isenterprise_checkbox.click if self.isenterprise_checkbox.selected? == false
    self.updatecompany_button.submit
    @wait.until {self.edit_button}
    
  end
  
  def _granify_company_destroy(company)
    #go to test users list
    @wait.until {self.test_dropdown}
    self.test_dropdown.click
    self.companies_menuitem.click
    @wait.until {self.search_textfield}
    
    #fill search field with username
    self.search_textfield.send_keys(company)

    #wait and destroy company 
    @wait.until {self.result_user(company)}
    self.companies_actions_dropdown.click
    self.destroy_menuitem_companies.click
      alert = @browser.switch_to.alert
      alert.accept
      sleep 5
  end
  
  def _granify_offer_create
    @wait.until {self.create_first_offer_button}
    self.create_first_offer_button.click
    @wait.until {self.offer_type_dropdown}
    self.offer_type_dropdown.find_elements(:tag_name => "option").find do |option|
      option.text == "Discount (Percent)"
    end.click
    
    self.headline_textfield.send_keys("Autotest offer")
    self.message_textfield.send_keys("10 per-cent test discount")
    
    $coupon = "TL2" + (0...8).map{65.+(rand(25))}.join
    self.coupon_code_textfield.send_keys("#{$coupon}")
    self.coupon_value_textfield.send_keys("10")
    self.offer_save_button.submit()
    begin
      @wait.until {self.offer_activate_checkbox}
    rescue
      return false
    end
    return true
    
  end
  def _granify_offer_activate
    @browser.get("#{$granify_url}offers")
    @wait.until {self.offer_activate_checkbox}
    self.offer_activate_checkbox.click if self.offer_activate_checkbox.selected? == false
    sleep 5
    begin
      @wait.until {self.offer_activate_checkbox.selected? == true}
    rescue
      return false
    end
    return true
  end
  def _granify_force_matching_cookie_set()
    @browser.get("http://granify.com")
    @browser.execute_script("javascript:document.cookie='force_matching='+(1-!!document.cookie.match('force_matching=1'))+';domain='+location.host;false;")                             
  end
  
  
  def _granify_dashboard_shopify_check
    @wait.until {self.dashboard_link}
    self.dashboard_link.click()
    begin
      @wait.until {self.dashboard_visitors}
    rescue
      return false
    end
    
    dashboard = {
       'visitors' => self.dashboard_visitors.text,
       'orders' => self.dashboard_orders.text,
       'revenue' => self.dashboard_revenue.text,
       'revenue_per_visitor' => dashboard_revenue_to_visitors.text,
       'impressions' => self.dashboard_impressions.text,
       "conversions" => self.dashboard_conversion.text
    }
    
    expected = {
       'visitors' => "1",
       "orders" => "1",
       "revenue" => "$100",
       "revenue_per_visitor" => "$100",
       "impressions" => "1",
       "conversions" => "1" 
    }
    
    if expected == dashboard
       return true
    else 
       return dashboard
    end
  end
  
  def _granify_visitorstream_shopify_check
    self.visits_link.click()
    @wait.until {self.export_to_csv_button}
    #begin
     @wait.until {self.visits_row1} 
     @wait.until {self.visits_row2}
    if (!self.visits_row1.text.include? "Offer Shown") || (!self.visits_row2.text.include? "Offer Shown")
      return false
    end
    if (!self.visits_row1.text.include? "#{$shopify_order_id}")
    end
    return true
  end
  def _granify_dashboard_magento_check
    @wait.until {self.dashboard_link}
    self.dashboard_link.click()
       begin
      @wait.until {self.dashboard_visitors}
    rescue
      return false
    end
    
    dashboard = {
       'visitors' => self.dashboard_visitors.text,
       'orders' => self.dashboard_orders.text,
       'revenue' => self.dashboard_revenue.text,
       'revenue_per_visitor' => dashboard_revenue_to_visitors.text,
       'impressions' => self.dashboard_impressions.text,
       "conversions" => self.dashboard_conversion.text
    }
    
    expected = {
       'visitors' => "1",
       "orders" => "1",
       "revenue" => "$100",
       "revenue_per_visitor" => "$100",
       "impressions" => "1",
       "conversions" => "1" 
    }
    
    if expected == dashboard
       return true
    else 
       return dashboard
    end 
    
  end
  
  def _granify_visitorstream_magento_check
    self.visits_link.click()
    @wait.until {self.export_to_csv_button}
    #begin
     @wait.until {self.visits_row1} 
#     @wait.until {self.visits_row2}

    if (!self.visits_row1.text.include? "Offer Shown")
      return false
    end
    if (!self.visits_row1.text.include? "#{$shopify_order_id}")
    end
    return true
  end
   def _statsforce_post_send(id)
    @browser.execute_script("document.body.innerHTML += '<form id=\"dynForm\" action=\"https://stage.app.granify.com/admin/queue/manager/add_to_queue\" method=\"post\"><input type=\"hidden\" name=\"worker\" value=\"OrdersSyncNewWorker\"><input type=\"hidden\" name=\"args\" value=\"#{id}\"></form>';document.getElementById(\"dynForm\").submit();")
    sleep 10
    @browser.execute_script("document.body.innerHTML += '<form id=\"dynForm\" action=\"https://stage.app.granify.com/admin/queue/manager/add_to_queue\" method=\"post\"><input type=\"hidden\" name=\"worker\" value=\"AdminUpdateStatsWorker\"><input type=\"hidden\" name=\"args\" value=\"\"></form>';document.getElementById(\"dynForm\").submit();")
    sleep 10
    @browser.execute_script("document.body.innerHTML += '<form id=\"dynForm\" action=\"https://stage.app.granify.com/admin/queue/manager/add_to_queue\" method=\"post\"><input type=\"hidden\" name=\"worker\" value=\"NewSiteOrdersSyncWorker\"><input type=\"hidden\" name=\"args\" value=\"\"></form>';document.getElementById(\"dynForm\").submit();")
    sleep 10
    @browser.execute_script("document.body.innerHTML += '<form id=\"dynForm\" action=\"https://stage.app.granify.com/admin/queue/manager/add_to_queue\" method=\"post\"><input type=\"hidden\" name=\"worker\" value=\"PredictionsSyncWorker\"><input type=\"hidden\" name=\"args\" value=\"\"></form>';document.getElementById(\"dynForm\").submit();")
    sleep 10
    @browser.execute_script("document.body.innerHTML += '<form id=\"dynForm\" action=\"https://stage.app.granify.com/admin/queue/manager/add_to_queue\" method=\"post\"><input type=\"hidden\" name=\"worker\" value=\"CacheFlushWorker\"><input type=\"hidden\" name=\"args\" value=\"\"></form>';document.getElementById(\"dynForm\").submit();")
    sleep 10
  end
  
  def _granify_cache_warmup()
    @browser.execute_script("document.body.innerHTML += '<form id=\"dynForm\" action=\"https://stage.app.granify.com/admin/queue/manager/add_to_queue\" method=\"post\"><input type=\"hidden\" name=\"worker\" value=\"CacheWarmerWorker\"><input type=\"hidden\" name=\"args\" value=\"\"></form>';document.getElementById(\"dynForm\").submit();")
    sleep 5
  end
end

class GranifyLoginPage < BasePage  #Object Repository for Granify Login page
  
  def success_signout_alert
    return @browser.find_element(:class, "alert fade in alert-success")
  end
  
  def login_email_textfield
    return @browser.find_element(:id, "user_email")
  end
  
  def login_password_textfield
    return @browser.find_element(:id, "user_password")
  end
  
  def signin_button
    return @browser.find_element(:name, "commit")
  end
  
  #Helpers for Granify Login Page
  def _granify_login(email, password)
    @wait.until {self.login_email_textfield}
    self.login_email_textfield.send_keys(email)
    self.login_password_textfield.send_keys(password)
    self.signin_button.submit
  end
  
end

