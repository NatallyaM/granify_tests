require 'inifile'

class ConfigSet #Sets global variables according to data in config.ini
    def initialize #later support for different environments could be added (environment section of config.ini)
    @inifile = IniFile.load('config.ini')   
    @config_settings = {}
    @config_settings = @inifile['staging']  
    
    variables_set
    
    end  
    
    def variables_set
      
      $granify_url = "#{@config_settings["granify_url"]}"
      $browser = @config_settings["browser"].to_sym
      $granify_admin_login = @config_settings["granify_admin_login"]
      $granify_admin_password = @config_settings["granify_admin_password"]
      $granify_magento_user_name = @config_settings["granify_magento_user_name"]
      $granify_magento_user_password = @config_settings["granify_magento_user_password"]
      $granify_magento_user_email = @config_settings["granify_magento_user_email"]
      $magento_store_default_link = @config_settings["magento_store_default_link"]
      $magento_store_storeview2_link = @config_settings["magento_store_storeview2_link"]
      $magento_store_storeview2_product_link = @config_settings["magento_store_storeview2_product_link"]
      $magento_store_site_name = @config_settings["magento_store_site_name"]
      $magento_admin_username = @config_settings["magento_admin_username"]
      $magento_admin_password = @config_settings["magento_admin_password"]
      $granify_shopify_user_name = @config_settings["granify_shopify_user_name"]
      $granify_shopify_user_password = @config_settings["granify_shopify_user_password"]
      $granify_shopify_user_email = @config_settings["granify_shopify_user_email"]
      $shopify_store_link = @config_settings["shopify_store_link"]
      $shopify_store_site_name = @config_settings["shopify_store_site_name"]
      $shopify_admin_username = @config_settings["shopify_admin_username"]
      $shopify_admin_password = @config_settings["shopify_admin_password"]
      
    end
end
