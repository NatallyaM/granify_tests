require 'selenium-webdriver'
require_relative 'ObjectRepository/or_granify'
require_relative 'ObjectRepository/or_magento'
require_relative 'Helpers/config_set'
gem "test-unit"
require 'test/unit'

class MagentoTests < Test::Unit::TestCase
    
#puts "@active_window class is #{@active_window.class}"
#puts "HTML code: #{@active_window.page_source}"
 

  def setup #opening new browser instance, maximizing browser window, connecting Granify  OR's
    ConfigSet.new()
    @active_window = Selenium::WebDriver.for $browser 
    @active_window.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 600)
    @granify_register = GranifyRegisterPage.new(@active_window)
    @granify_members_area = GranifyMemberArea.new(@active_window)
    @granify_login_page = GranifyLoginPage.new(@active_window)
    @magento_admin_page = MagentoAdminPage.new(@active_window)
    @magento_shop_page = MagentoShopPage.new(@active_window)
    
  end
  
  def teardown
     @active_window.save_screenshot File.join(ENV['CIRCLE_ARTIFACTS'], "Magento" + "_" + Time.now.strftime("%F_%H%M%S") + "_" + @method_name + ".png") rescue nil
     @active_window.close
  end
  
  def test_000_magento_cleanup # Cleaning up test data before test run
    begin
    # Remove granify account
    @active_window.get "#{$granify_url}"
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    @granify_members_area._granify_company_destroy($magento_store_site_name)
    rescue
    end
    begin
    # remove granify plugin on magento side
    @active_window.get "#{$magento_store_default_link}admin"
    @magento_admin_page._magento_admin_login()
    @magento_admin_page._magento_goto_connectmanager()
    @magento_admin_page._magento_admin_secondary_login()
    @magento_admin_page._magento_granify_plugin_uninstall()
    rescue
    end
  end
  
=begin  
  def test_001_magento_registration # Creation customer's account on Granify.com
    begin
    #Navigate to http://stage.app.granify.com/sign_up?test=magento 
    @active_window.get "#{$granify_url}sign_up?test=magento"
    
    #Register Granify Magento test user using random valid data
    @granify_register._register_random("magento")
    
    #to check if user logged in to MA
    
    #Logging out from members area
    @granify_members_area._granify_user_logout()
    
    #to check if user redirectred to sign-up page
    
    #logging in as Granify Administrator
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    
    #to check if login procedure competed succesfully

    #find and destroy created user
    assert(@granify_members_area._granify_testuser_search("#{$granify_mock_user}"), "Test user #{$granify_mock_user} not found")
    @granify_members_area._granify_user_destroy("#{$granify_mock_user}")
    rescue => error
      @active_window.close
      raise error
    end
  end
 
=end  
  def test_002_offer_creation #Creation an offer and force matching
    begin  
    
    #Navigate to http://stage.app.granify.com/sign_up?test=magento 
    @active_window.get "#{$granify_url}sign_up?test=magento"
  
    #create customer's account for this user using test store URL on http://stage.app.granify.com/sign_up?test=magento
    @granify_register._register()
    
    #Logging out from members area
    @granify_members_area._granify_user_logout()  
    #Make previously created granify magento user enterprise
    #@active_window.get "#{$granify_url}"
    #@granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    #@granify_members_area._granify_set_company_enterprise($magento_store_site_name)
    #@granify_members_area._granify_admin_logout()
    
    #log in to customer account for test store with user created at 2.
    @granify_login_page._granify_login($granify_magento_user_email, $granify_magento_user_password)
    
    #to check if correct user is logged in        
    
    #create and activate test offer
    assert(@granify_members_area._granify_offer_create(), "Offer creation failed")
    
    #commented 'activate_offer' since now offer is active by default
    #assert(@granify_members_area._granify_offer_activate(), "Offer activation failed")
    
    @granify_members_area._granify_get_plugin_link()
    
    #login to magento admin/install granify plugin http://granifyqa.kv.kirby.pp.ua/11011/
    @active_window.get "#{$magento_store_default_link}admin"
    @magento_admin_page._magento_admin_login()
  
    # to verify if login procedure completed succesfully  
    
    @magento_admin_page._magento_goto_connectmanager()
    @magento_admin_page._magento_admin_secondary_login()
    assert(@magento_admin_page._magento_granify_plugin_upload(), "Failed to upload magento granify plugin")
  
    #flush magento caches
    @active_window.get "#{$magento_store_default_link}admin"
    assert(@magento_admin_page._magento_cache_flush(), "Failed to flush magento caches")
 
    #confirm installation on granify side
    @active_window.get "#{$granify_url}"
    @granify_members_area._granify_magento_installation_confirm()
    assert(@granify_members_area._granify_installation_verify(), "Granify installation confirmation message not appeared on granify user page")
  
    #confirm installation of plugin via magento shop source
    @active_window.get "#{$magento_store_default_link}"
    assert(@magento_shop_page._magento_plugin_sourcecode_verify(), "Granify script didn't found in magento shop user page source")
    rescue => error
      @active_window.close
      raise error
    end
    
    @active_window.get "#{$granify_url}sign_out"
    puts ""
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    @granify_members_area._granify_cache_warmup()
    sleep 120
    @active_window.get "#{$granify_url}sign_out"
    
    
    
    
    # Set force matching cookie
    sleep 120
    @granify_members_area._granify_force_matching_cookie_set()
    
    puts "@active_window class is #{@active_window.class}"
    
    #verify if offer appears shown on shop page
    @active_window.get "#{$magento_store_default_link}"#catalog/product/view/id/2/s/automation-test-product/"
    assert(@magento_shop_page._offer_verify, "Offer not appeared or offer information is wrong")
    rescue => error
      @active_window.close
      raise error
    end 
  end  
 
  
  def test_003_plugin_installation #installation of Granify plugin to magento test shop
  begin    
  #to check if members area opened
  
  
  end
  
  
  def test_004_purchase_making #Making a purchase.
    begin
    #login to magento admin
    @active_window.get "#{$magento_store_default_link}admin"
    @magento_admin_page._magento_admin_login()
    assert(@magento_admin_page._magento_offer_create(), "Failed to create promotion on magento side")
    
    #Set force matching cookie
    @granify_members_area._granify_force_matching_cookie_set()
    
    #Create an order
    @active_window.get "#{$magento_store_default_link}automation-test-product.html"
    sleep 2
    session_id = @active_window.execute_script("return Granify.UUID")
    @magento_shop_page._magento_order_submit()
    
    @active_window.get "#{$magento_store_default_link}admin"
    @magento_admin_page._magento_order_confirm()
    
    #Force stats update by sending post request
    @active_window.get $granify_url
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    id = @granify_members_area._granify_get_store_id($magento_store_site_name)
    @granify_members_area._statsforce_post_send(id)
    
    
=begin
   
    #check stats on dashboard
    @active_window.get "#{$granify_url}sign_out"
    @granify_login_page._granify_login($granify_magento_user_email, $granify_magento_user_password)
    assert(@granify_members_area._granify_dashboard_magento_check(), "Dashboard stats check failed, Granify.UUID = #{session_id}")
 
    #check stats on visits page
    assert(@granify_members_area._granify_visitorstream_magento_check(), "Visits stats check failed, Granify.UUID = #{session_id}")

    rescue => error
      @active_window.close
      raise error
    end
  end
  


  def test_005_multiple_shops #Verify proper installation of a plugin on the environment with multiple magento shops on a single codebase instance
    begin
    begin
    # Remove granify account
    @active_window.get "#{$granify_url}"
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    @granify_members_area._granify_company_destroy($magento_store_site_name)

    rescue
#      assert(false, "Failed to remove granify account")
    end
    begin
    # remove granify plugin on magento side
    @active_window.get "#{$magento_store_default_link}admin"
    @magento_admin_page._magento_admin_login()
    @magento_admin_page._magento_goto_connectmanager()
    @magento_admin_page._magento_admin_secondary_login()
    @magento_admin_page._magento_granify_plugin_uninstall()
    rescue
#      assert(false, "Failed to remove granify plugin on magento side")
    end
    
    #flush magento caches
    sleep 5
    @active_window.get "#{$magento_store_default_link}admin"
    assert(@magento_admin_page._magento_cache_flush(), "Failed to flush magento caches")
    
    #Navigate to http://stage.app.granify.com/sign_up?test=magento 
    @active_window.get "https://stage.app.granify.com/sign_out"
    @active_window.get "#{$granify_url}sign_up?test=magento"
  
    #create customer's account for this user using test store URL on http://stage.app.granify.com/sign_up?test=magento
    @granify_register._register()
  
    #to check if members area opened
    @granify_members_area._granify_get_plugin_link()
  
    
    #login to magento admin/install granify plugin http://granifyqa.kv.kirby.pp.ua/11011/
    @active_window.get "#{$magento_store_default_link}admin"

    
    @magento_admin_page._magento_goto_connectmanager()
    assert(@magento_admin_page._magento_granify_plugin_upload(), "Failed to upload magento granify plugin")
  
  
    #flush magento caches
    @active_window.get "#{$magento_store_default_link}admin"
    assert(@magento_admin_page._magento_cache_flush(), "Failed to flush magento caches")
  
    #confirm installation on granify side
    @active_window.get "#{$granify_url}"
    @granify_members_area._granify_magento_installation_confirm("Second Website Store View 2")
    assert(@granify_members_area._granify_installation_verify(), "Granify installation confirmation message not appeared on granify user page")
    
    #Make previously created granify magento user enterprise
    @active_window.get "#{$granify_url}sign_out"

#   commented 3 lines which were created to set company=enterprise while test stores were obliged to use credit card credentials too 
#   @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
#   @granify_members_area._granify_set_company_enterprise($magento_store_site_name)
#   @granify_members_area._granify_admin_logout()
    
    #log in to customer account for test store with user created at 2.
    @granify_login_page._granify_login($granify_magento_user_email, $granify_magento_user_password)
    
    #to check if correct user is logged in        
    
    #create and activate test offer
    assert(@granify_members_area._granify_offer_create(), "Offer creation failed")
    assert(@granify_members_area._granify_offer_activate(), "Offer activation failed")
    @active_window.get "#{$granify_url}sign_out"
    puts ""
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    @granify_members_area._granify_cache_warmup()
    @active_window.get "#{$granify_url}sign_out"
    #login to magento admin
    @active_window.get "#{$magento_store_default_link}admin"
    assert(@magento_admin_page._magento_offer_create(), "Failed to create promotion on magento side")
    
    #Set force matching cookie
    @granify_members_area._granify_force_matching_cookie_set()
    
    #Create an order
    @active_window.get "#{$magento_store_default_link}automation-test-product.html?___store=s2"
    sleep 2
    session_id = @active_window.execute_script("return Granify.UUID")
    @magento_shop_page._magento_order_submit()
    
    @active_window.get "#{$magento_store_default_link}admin"
    @magento_admin_page._magento_order_confirm()
    
    #Force stats update by sending post request
    @active_window.get $granify_url
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    id = @granify_members_area._granify_get_store_id($magento_store_site_name)
    @granify_members_area._statsforce_post_send(id)
    
    #check stats on dashboard
    @active_window.get "#{$granify_url}sign_out"
    @granify_login_page._granify_login($granify_magento_user_email, $granify_magento_user_password)
    assert(@granify_members_area._granify_dashboard_magento_check(), "Dashboard stats check failed, Granify.UUID = #{session_id}")
 
    #check stats on visits page
    assert(@granify_members_area._granify_visitorstream_magento_check(), "Visits stats check failed, Granify.UUID = #{session_id}")
    
    #@active_window.get "#{$magento_store_default_link}admin"
    #assert(@magento_admin_page._magento_multiple_storeview_check(), "Site ID\\API Secret verification failed.")
    rescue => error
      @active_window.close
      raise error
      end 
=end
end



 
