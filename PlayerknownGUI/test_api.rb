#Author: Tucker Myers
#Date: 4/22/2018
#File: test_api.rb

#include the api handler
require_relative 'api.rb'
require 'fox16'
include Fox
#Test code 

myApi = API_Handler.new
match_list = myApi.grabMatchWithUsername("Krunge", 1)
