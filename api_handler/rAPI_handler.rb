# Name:	 			Tucker Myers
# Date Created: 	04/14/2018
# File Name: 		PUBG_rAPI.rb
# Git:  			https://myersTD@bitbucket.org/rpubg/rpubg.git

require 'net/https'
require 'net/http'
require 'openssl'
require 'json'
require 'httparty'
require 'uri'
require 'rest-client'

class API_Handler
	attr_accessor :m_platform, :m_region, :m_headerAccept, :m_key, :m_filter_match, :m_filter_playername

	def initialize(my_api_key)
		#Initialize class variables
		@m_key = my_api_key
		@m_platform = "pc"
		@m_region = "na"
		@m_headerAccept = "application/vnd.api+json"
		@m_url = "https://api.playbattlegrounds.com/shards/" + @m_platform + "-" + @m_region + "/"
		@m_filter_playername = "players?filter[playerNames]="
		@m_filter_match = "matches/"
	end

	def setBounds(region, platform)
		@m_region = region
		@m_platform = platform
		@m_url =  "https://api.playbattlegrounds.com/shards/" + @m_platform + "-" + @m_region + "/"
	end

	def grabMatchWithUsername(player_username, number_of_matches)
		#Make a get request to the api
		res = RestClient::Request.execute(
			:method => :get,
			:url => @m_url + @m_filter_playername + player_username,
			:headers => {Authorization: @m_key, Accept: "application/vnd.api+json"}
		)
     	#Parse the JSON object that is returned
     	res = JSON.parse(res)
		data = res['data'][0]
		#puts data
		matches = data['relationships']['matches']['data']

		# limit api calls to 10 in a session
		match_list = Array.new
		i = 0
		for _match in  matches
			if (i < number_of_matches)
				new_match_id = _match['id']
				new_match = grabMatch(new_match_id) 
				match_list.push(new_match)
			end
			i = i + 1
		end
		return match_list
	end 
 
	def grabMatch(match_id)

		res = RestClient::Request.execute(
			:method => :get,
			:url => @m_url + @m_filter_match + match_id,
			:headers => {Authorization: @m_key, Accept: "application/vnd.api+json"}
			)

		res = JSON.parse(res)

		data = res['data']
		attributes = data['attributes']

		duration = attributes['duration']
		mapname = attributes['mapName']
		gamemode = attributes['gameMode']

		roster_array = Array.new  
		for roster in data['relationships']['rosters']['data']
			roster_array.push(roster['id'])
		end
		#Create a hash table of the players and teams
		match_entities = parseMatch(res['included'])
		this_match = parseEntities(match_entities, roster_array, duration, mapname, gamemode)
		return this_match
	end 

	def createPlayer(data)
		stats = data['attributes']['stats']
		playername =stats['name']
		playerid = data['id']
		damage = stats['damageDealt']
		distance = stats['walkDistance'] + stats['rideDistance']
		kills = stats['kills']
		longestkill = stats['longestKill']
		deathtype = stats['deathType']

		new_player = Player_Stats.new(playername, playerid, damage, distance, kills, longestkill, deathtype)
		return new_player
	end

	def createRoster(data)
		rank = data['attributes']['stats']['rank']
		teamnumber = data['attributes']['stats']['teamId']
		#puts teamnumber
		#won? = data['attributes']['won']
		player_id_list = Array.new
		player_list = data['relationships']['participants']['data']
		for player in player_list
			player_id_list.push(player['id'])
		end

		new_roster = Roster.new(teamnumber, rank, player_id_list)
		return new_roster
	end

	def createTeam(entities_list, roster_id)
		player_array = Array.new
		roster = entities_list[roster_id]
		for id in roster.m_ids
			player_array.push(entities_list[id])
		end
		new_team = Team_Stats.new(roster.m_teamnumber, roster.m_rank, player_array)
		return new_team
	end

	def parseMatch(data)

		new_entities = {}
		for entity in data
			if (entity['type'] == "participant")
				new_entities.merge!("#{entity['id']}" => createPlayer(entity))
			end
			if (entity['type'] == "roster")
				new_entities.merge!("#{entity['id']}" => createRoster(entity))
			end
		end
		return new_entities
	end 

	def parseEntities(entities_list, roster_list, duration, mapname, gamemode)
		team_array = Array.new
		for roster_id in roster_list
			team_array.push(createTeam(entities_list, roster_id))
		end
		new_match = Match_Stats.new(team_array, duration, mapname, gamemode)
		return new_match
	end
end

class Roster
	attr_accessor :m_teamnumber, :m_rank, :m_ids
	def initialize(teamnumber, rank, players)
		@m_teamnumber = teamnumber
		@m_rank = rank
		@m_ids = players
	end
end

class Player_Stats
	attr_accessor :m_name, :m_id, :m_damage, :m_distance, :m_kills, :m_longestkill, :m_deathtype
	def initialize(playername, id, damage, distance, kills, longestkill, deathtype)
		@m_name = playername
		@m_id = id
		@m_damage = damage
		@m_distance = distance
		@m_kills = kills
		@m_longestkill = longestkill
		@m_deathtype = deathtype
	end
end		

class Team_Stats
	attr_accessor :m_teamnumber, :m_rank, :m_players
	def initialize(teamnumber, rank, players)
		@m_teamnumber = teamnumber
		@m_rank = rank
		@m_players = players
	end
end

class Match_Stats
	attr_accessor :m_teams, :m_duration, :m_map, :m_gamemode
	def initialize(teams, duration, mapname, gamemode)
		@m_teams = teams
		@m_duration = duration
		@m_map = mapname
		@m_gamemode = gamemode
	end 
end