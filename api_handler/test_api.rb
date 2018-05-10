#Author: Tucker Myers
#Date: 4/22/2018
#File: test_api.rb

#include the api handler
require_relative 'rAPI_handler.rb'

#Test code 

def displayMatch(match)
	puts "Map: " + match.m_map
	duration = match.m_duration / 60
	puts "Duration: " + duration.to_s
	puts "Gamemode: " + match.m_gamemode.to_s

	for team in match.m_teams
		puts "Squad number:" + team.m_teamnumber.to_s + ":"
		puts "Rank:" + team.m_rank.to_s
		for player in team.m_players
			puts player.m_name + ":"
			puts "Kills:" + player.m_kills.to_s
		end
	end
end

#dont let other people mess with your api
myApi = API_Handler.new("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIyODkwYWRhMC0yMmJiLTAxMzYtODU2OS0xZGY5Mjc3MjU3ZmYiLCJpc3MiOiJnYW1lbG9ja2VyIiwiaWF0IjoxNTIzNzgzNTk3LCJwdWIiOiJibHVlaG9sZSIsInRpdGxlIjoicHViZyIsImFwcCI6InBsYXllcmtub3ducyIsInNjb3BlIjoiY29tbXVuaXR5IiwibGltaXQiOjEwfQ.VOVhXVpcfAzwxIutHKRuSTi7dApBnriowsl0cmcszNc")
match_list = myApi.grabMatchWithUsername("Krunge", 1)
displayMatch(match_list[0])