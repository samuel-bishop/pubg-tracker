#Author: Tucker Myers
#Date: 4/22/2018
#File: test_api.rb

#include the api handler
require_relative 'rAPI_handler.rb'
require 'fox16'
include Fox
#Test code 

app = FXApp.new
main = FXMainWindow.new(app, "Welcome", :width => 250, :height => 100)
searchTarget = FXDataTarget.new("")
seachField = FXTextField.new(main, 16, searchTarget, FXDataTarget::ID_VALUE, TEXTFIELD_NORMAL|LAYOUT_FILL_X|LAYOUT_FILL_COLUMN)
FXButton.new(main, "Search", nil, app, FXApp::ID_QUIT)
app.create
main.show(PLACEMENT_SCREEN)
app.run



#dont let other people mess with your api
# myApi = API_Handler.new
# match_list = myApi.grabMatchWithUsername("Krunge", 1)
# myApi.displayMatch(match_list[0])