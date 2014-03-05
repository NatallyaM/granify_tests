require 'selenium-webdriver'
require_relative 'ObjectRepository/or_granify'
require_relative 'ObjectRepository/or_magento'
require_relative 'ObjectRepository/or_shopify'
require_relative 'Helpers/config_set'
gem "test-unit"
require 'test/unit'

class ShopifyTests < Test::Unit::TestCase

  def setup
    ConfigSet.new()
    @active_window = Selenium::WebDriver.for $browser 
    @active_window.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    @granify_register = GranifyRegisterPage.new(@active_window)
    @granify_members_area = GranifyMemberArea.new(@active_window)
    @granify_login_page = GranifyLoginPage.new(@active_window)
    @shopify_login_page = ShopifyLoginPage.new(@active_window)
    @shopify_members_area = ShopifyAdminArea.new(@active_window)
    @shopify_shop_page = ShopifyShopPage.new(@active_window)

    
  end
  
  def teardown
     @active_window.save_screenshot File.join(ENV['CIRCLE_ARTIFACTS'], "Shopify"+"_"+Time.now.strftime("%F_%H%M%S") + "_" + @method_name + ".png") rescue nil
     @active_window.close
  end
   
  def test_000_shopify_cleanup # Cleaning up test data before test run
    begin
    # Remove granify account
    @active_window.get "#{$granify_url}"
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    @granify_members_area._granify_company_destroy($shopify_store_site_name)
    @active_window.close
    rescue
    end
    begin
    # remove granify plugin on shopify side
    @active_window.get "#{$shopify_store_link}/admin"
    @shopify_login_page._shopify_login()
    @shopify_members_area._granify_plugin_uninstall
    rescue
    end
  end

=begin
  def test_001_shopify_registration # Creation customer's account on Granify.com
    begin
    #Navigate to http://stage.app.granify.com/sign_up?test=shopify 
    @active_window.get "#{$granify_url}sign_up?test=shopify"
    
    #Register Granify Shopify test user using random valid data
    @granify_register._register_random("shopify")
    
    #to check if user logged in to MA
    
    #Logging out from members area
    @granify_members_area._granify_user_logout()
    
    #to check if user redirectred to sign-up page
    
    #logging in as Granify Administrator
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    
    #to check if login procedure competed successfully

    #find and destroy created user
    assert(@granify_members_area._granify_testuser_search("#{$granify_mock_user}"), "Test user #{$granify_mock_user} not found")
    @granify_members_area._granify_user_destroy("#{$granify_mock_user}")
    rescue => error
      @active_window.close
      raise error
    end
    @active_window.close
  end
  
=end 
  
  def test_002_shopify_offer_creation  #installation of Granify plugin to shopify test shop
  begin    
  #Navigate to http://stage.app.granify.com/sign_up?test=magento 
  @active_window.get "#{$granify_url}sign_up?test=shopify"
 
  
  #create customer's account for this user using test store URL on http://stage.app.granify.com/sign_up?test=magento
  @granify_register._register($granify_shopify_user_name, $granify_shopify_user_password, $granify_shopify_user_email, $granify_shopify_user_phone, $shopify_store_link,"shopify")
  
  #to check if members area opened
  begin
    @wait.until {@granify_members_area.user_account_menu_dropdown}
  rescue
    assert(false, "Login to granify members area failed")    
  end
  
=begin  
   #Logging out from members area
    @granify_members_area._granify_user_logout()  
    
   # log in to customer account for test store with user created at 2.
   @granify_login_page._granify_login($granify_shopify_user_email, $granify_shopify_user_password)
 
=end


   # created and activate offer
    assert(@granify_members_area._granify_offer_create(), "Failed to create test offer for shopify")
   # @granify_members_area._granify_offer_activate()#, "Failed to activate offer")
   # @active_window.get "#{$granify_url}sign_out"  
    
   @granify_members_area._granify_continue_to_shopify_link() 
    
   #Click "continue to shopify" button
   @granify_members_area.continue_to_shopify_button.click
   
   #verify if shopify login page opened
   begin
     @wait.until {@shopify_login_page.email_textfiled}
   rescue
     assert(false, "User wasn't redirected to shopify login page")
   end
   
   #Login to shopify
   @shopify_login_page._shopify_login()
   #Click Install button
  # @wait.until {@shopify_members_area.install_app_button}
   #@shopify_members_area.install_app_button.click
   
   #Check if user redirected to granify members area and installation was successful
   assert(@granify_members_area._granify_installation_verify(), "Granify installation wasn't confirmed on granify side")
   
   #check granify installation on shop page
   @active_window.get "#{$shopify_store_link}"
   assert(@shopify_shop_page._shopify_plugin_sourcecode_verify(), "Source code granify install verification for shopify failed")
   rescue => error
      @active_window.close
      raise error
    end
  end

  def test_003_shopify_plugin_installation
    begin
    # Set created company enterprise
    @active_window.get $granify_url
    #@granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    #@granify_members_area._granify_set_company_enterprise($shopify_store_site_name)
    #@granify_members_area._granify_admin_logout()
    
    # log in to customer account for test store with user created at 2.
   # @granify_login_page._granify_login($granify_shopify_user_email, $granify_shopify_user_password)
    

    
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    @granify_members_area._granify_cache_warmup()
    sleep 120
    
    @active_window.get "#{$granify_url}sign_out"
      
    #trigger force_matching cookie
    @granify_members_area._granify_force_matching_cookie_set()
    
    
    #go to shopify shop page
    @active_window.get($shopify_store_link)    
    sleep 5
    assert(@shopify_shop_page._offer_verify, "Offer not appeared or offer information is wrong")
    rescue => error
      @active_window.close
      raise error
    end
  end
  
=begin
  def test_004_shopify_purchase_stats_verification
    begin
    #create discount in shopify admin area
    @active_window.get "#{$shopify_store_link}/admin"
    @shopify_login_page._shopify_login()
    assert(@shopify_members_area._discount_create(), "Failed to create discount on shopify side")
    
    #trigger force_matching cookie
    @granify_members_area._granify_force_matching_cookie_set()
    
    #go to shopify shop page
    @active_window.get("#{$shopify_store_link}products/automation-test-product")    
    sleep 5
    session_id = @active_window.execute_script("return Granify.UUID")
    assert(@shopify_shop_page._offer_verify, "Offer not appeared or offer information is wrong")
    
    #make a purchase
    assert(@shopify_shop_page._shopify_purchase(), "Failed to submit shopify order")
    
    @active_window.get $granify_url
    @granify_login_page._granify_login($granify_admin_login, $granify_admin_password)
    id = @granify_members_area._granify_get_store_id($shopify_store_site_name)
    @granify_members_area._statsforce_post_send(id)

 
=begin  
    
    #check stats on dashboard
    @active_window.get "#{$granify_url}sign_out"
    @granify_login_page._granify_login($granify_shopify_user_email, $granify_shopify_user_password)
    assert(@granify_members_area._granify_dashboard_shopify_check(), "Dashboard stats check failed, Granify.UUID = #{session_id}")
 
    #check stats on visits page
    assert(@granify_members_area._granify_visitorstream_shopify_check(), "Visits stats check failed, Granify.UUID = #{session_id}")
    rescue => error
      @active_window.close
      raise error
=end

    end


  end
 
  
  
end


