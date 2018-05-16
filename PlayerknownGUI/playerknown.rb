require_relative 'api.rb'
require 'fox16'
include Fox

class DisplayWindow < FXMainWindow
	def initialize(app, matchlist)
	  super(app, "Results", :width => 500, :height => 300, :x => 50, :y => 50)
	    vFrame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL)
		vFrame.width = 400
		vFrame.height = 250
		textArea = FXText.new(vFrame,:opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)
		for match in matchlist
			textArea.appendText("Match: " + match.m_map + "\n")
		end 
	end
	def create
		super
		show()
	end
end 

class SearchBar < FXMainWindow
  def initialize(app)
    super(app, "PlayerKnown" , :width => 1000, :height => 325, :padLeft => 10)
	api = API_Handler.new()
	vFrame = FXVerticalFrame.new(self)
	pHFrame = FXVerticalFrame.new(self, FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y, :width=>400, :height => 100)
	image = FXJPGImage.new(app, nil)
	imageFile = FXFileStream.open("banner.jpg", FXStreamLoad)
	image.loadPixels(imageFile)
	image.create
	imageView = FXImageView.new(pHFrame, nil, nil, 0, VSCROLLER_ALWAYS|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	imageView.image = image
	hFrame = FXHorizontalFrame.new(vFrame)
	usernameLabel = FXLabel.new(hFrame, "Username")
	searchBar = FXTextField.new(hFrame, 50)
	searchButton = FXButton.new(hFrame, "Search")
	
	searchButton.connect(SEL_COMMAND) do
		input = searchBar.text
		match_list = api.grabMatchWithUsername(input, 5)
		displayWindow = DisplayWindow.new(app, match_list)
		displayWindow.create
	end
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
SearchBar.new(app)
app.create
app.run