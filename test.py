from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import  re



class trade(object):
    def __init__(self,dr):
        self.dr = dr

    def login_otcbtc(self):
        self.dr.get( 'http://www.otcbtc.com' )
        time.sleep( 5 )

        buttun = self.dr.find_element_by_class_name( 'log-in-btn' )
        buttun.click()
        time.sleep( 5 )

        user = self.dr.find_element_by_id( 'user_email' )
        user.send_keys( 'user_email' )

        pwd = self.dr.find_element_by_id( 'user_password' )
        pwd.send_keys( 'password' )

        log_in_btn = self.dr.find_element_by_name( 'commit' )
        log_in_btn.click()
        time.sleep( 5 )

        print( u"请输入验证码" )
        time.sleep( 5 )

    def get_market_otceth(self):
        self.dr.get("https://bb.otcbtc.com/exchange/markets/otbeth")




dr = webdriver.Chrome('/Users/Hebbelu/Downloads/chromedriver')
otcbtc = trade(dr)


