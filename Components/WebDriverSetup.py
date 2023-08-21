import os

from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from webdrivermanager import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager

def get_browserdriver_path(browser):
    print("Setup browser: " + browser)
    #disable_certificate_verification_for_wdm()
    if (browser == 'chrome'):
        return get_chromedriver_path()
    if (browser == 'firefox'):
        return get_firefoxdriver_path()
    if (browser == 'edge'):
        return get_edgedriver_path()
    return ""
    
def get_chromedriver_path():
    #driver_path = ChromeDriverManager().install()
    chrome_service = ChromeService() 
    driver_path = chrome_service.path 
    print(driver_path)
    return  driver_path
    
def get_firefoxdriver_path():
    dm = GeckoDriverManager()
    result = dm.download_and_install(version="compatible")
    driver_path = result[1]
    print(driver_path)
    return  driver_path
    
def get_edgedriver_path():
    driver_path = EdgeChromiumDriverManager().install()
    print(driver_path)
    return  driver_path

def get_firefox_profile():
    profile = webdriver.FirefoxProfile()
    profile.accept_untrusted_certs = True

def disable_certificate_verification_for_wdm():
    os.environ['WDM_SSL_VERIFY']='0'