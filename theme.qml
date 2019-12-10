import QtQuick 2.12
FocusScope {
	
	//colors
	property var lightgreen: "#00D455"
	property var green: "#008033"
	property var darkgreen: "#005522"
	property var lightblue: "#00AAD4"
	property var blue: "#0044AA"
	property var darkblue: "#000080"
	property var lightpink: "#FF2A7F"
	property var pink: "#FF0066"
	property var purple: "#800033"
	property var lightyellow: "#FFCC00"
	property var yellow: "#AA8800"
	property var darkyellow: "#554400"
	property var orange: "#EE5A24"
	property var lightred: "#FF0000"
	property var red: "#D40000"
	property var darkred: "#AA0000"
	property var white: "#ecf0f1"
	property var darkgray: "#2f3640"
	
	//modify here to change colors
	//color variables
	property var textColor: white
	property var highlightColor: white
	property var centerPaneBackground: "black"
	property var leftPaneBackground: blue
	property var rightPaneBackground: blue
	property var gameBoxBackgroundColor: darkgray
	
	//modify here to change language | 0 = English, 1 = Portuguese
	property int languageValue: 0;
	
	//current index values
	property int collectionValue: 0; 
	property int highlightColorValue: 17;
	property int leftPaneColorValue: 4;
	property int centerPaneColorValue: 19;
	property int rightPaneColorValue: 4;
	property int gameboxColorValue: 18;
	property int textColorValue: 17;
	
	property var collectionData: api.collections.get(0);
	
	//border and spaces
	property int spaceBetweenGames: 10; 
	property int borderSize: 5;
	
	//font sizes
	property int titleFontSize: 24;
	property int subtitleFontSize: 16;
	property int fontSize: 14;
	property int detailsFontSize: 16;
	
	property bool isRightPanelOpen: true;
	

	//language variables
	property var langCollections: "Collections"
	property var langSettings: "Settings"
	property var langCenterPaneColor: "Center pane color"
	property var langLeftPaneColor: "Left pane color"
	property var langRightPaneColor: "Right pane color"
	property var langTextColor: "Text color"
	property var langGameBoxColor: "Game box color"
	property var langDeveloper: "Developer"
	property var langGenre: "Genre"
	property var langPlayers: "Players"
	property var langPublisher: "Publisher"
	property var langHighlight: "Highlight color"
	property var langLanguage: "English"
	property var langLang: "Language"
	
		
	
	Item{
		id: root
		anchors.fill: parent
		// leftpane
		
		Rectangle{
			id: collectionPane
			
			anchors.left: parent.left
			anchors.top: parent.top
			height: parent.height
			width: (parent.width/10)*2
			
			color: leftPaneBackground
			
			visible: true
			
			Image{
				anchors.fill: parent
				
				source: "assets/panebackground.png"
					
				visible: true

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectCrop 
					
				asynchronous: true
				sourceSize { width: parent.width ; height: parent.height }
				
			}
			
			
			Text {
				id: collectionTitle
				text: langCollections

				anchors.top: parent.top
				anchors.left: parent.left
				anchors.leftMargin: borderSize
				anchors.topMargin: borderSize
				width: parent.width
				height: titleFontSize
				
				horizontalAlignment: Text.AlignHCenter
				//verticalAlignment: Text.AlignVCenter
				wrapMode: Text.Wrap
				maximumLineCount:1

				color: textColor
				font.pixelSize: titleFontSize
				font.family: globalFonts.sans
				font.bold: true
			}
				
			ListView {
				id: leftPaneListView
				
				anchors.top: collectionTitle.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.bottom: parent.bottom
				anchors.leftMargin: borderSize*2
				anchors.topMargin: borderSize*4
				anchors.rightMargin: borderSize*2
				anchors.bottomMargin: borderSize*2

				model: api.collections
				
				delegate: leftPaneDelegate
				
				spacing: borderSize*5 //space between items
							
			}
			
			Rectangle{
				id: highlightLeftPane
				//anchors.fill: parent
				//anchors.top: parent.top
				//anchors.left: parent.left
				
				
				x: leftPaneListView.currentItem.x 
				y: leftPaneListView.currentItem.y + (borderSize*4) + collectionTitle.height
				
				height: 30
				width: parent.width
				
				color: centerPaneBackground
				border.color: centerPaneBackground
				border.width: borderSize
						
				Behavior on x { SmoothedAnimation { duration: 150 } }
				Behavior on y { SmoothedAnimation { duration: 150 } }
				
				
				Text {
					
					text: {
						if (api.collections.get(collectionValue).name == "Super Nintendo Entertainment System")
							"Super NES"
						else if (api.collections.get(collectionValue).name == "Nintendo Entertainment System")
							"NES"
						else if (api.collections.get(collectionValue).name == "Nintendo Game Boy Advance")
							"Nintendo GBA" 
						else if (api.collections.get(collectionValue).name == "Nintendo Game Boy Color")
							"Nintendo GBC"
						else if (api.collections.get(collectionValue).name == "Nintendo - Nintendo DS")
							"Nintendo DS"
						else
							api.collections.get(collectionValue).name
						}

											
					anchors.fill: parent
					anchors.topMargin: borderSize
					anchors.leftMargin: borderSize*2
					
					width: parent.width - 30
					height: subtitleFontSize
					
					// align to the center
					//horizontalAlignment: Text.AlignHCenter
					//verticalAlignment: Text.AlignVCenter
					wrapMode: Text.Wrap
					maximumLineCount:1

					color: textColor
					font.pixelSize: subtitleFontSize
					font.family: globalFonts.sans
					font.bold: true
				}
				Text{
					text: {
						if(api.collections.get(collectionValue).games.count>9999)
							"9999"
						else
							api.collections.get(collectionValue).games.count
					}		
					
					anchors.fill: parent
					anchors.topMargin: borderSize
					anchors.leftMargin: borderSize*2
					anchors.rightMargin: borderSize*2
					
					width: 20
					height: subtitleFontSize
					
					horizontalAlignment: Text.AlignRight
					//verticalAlignment: Text.AlignVCenter
					wrapMode: Text.Wrap
					maximumLineCount:1

					color: textColor
					font.pixelSize: subtitleFontSize
					font.family: globalFonts.sans
					font.bold: true
				}
			}
				
			Component{
				id: leftPaneDelegate
				
				Item{
					anchors.left: parent.left
					anchors.right: parent.right
						Text {
							id: collectionName
							
							text: {
								if (modelData.name == "Super Nintendo Entertainment System")
									"Super NES"
								else if (modelData.name == "Nintendo Entertainment System")
									"NES"
								else if (modelData.name == "Nintendo Game Boy Advance")
									"Nintendo GBA"
								else if (modelData.name == "Nintendo Game Boy Color")
									"Nintendo GBC"
								else if (modelData.name == "Nintendo - Nintendo DS")
									"Nintendo DS"
								else
									modelData.name
								}
		
							anchors.fill: parent
							width: parent.width - 30
							height: subtitleFontSize
							
							//horizontalAlignment: Text.AlignHCenter
							//verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap
							maximumLineCount:1

							color: textColor
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
						Text{
							text: {
								if(modelData.games.count>9999)
									"9999"
								else
									modelData.games.count
							}
							anchors.fill: parent
							anchors.leftMargin: borderSize*2
							
							width: 20
							height: subtitleFontSize
							
							horizontalAlignment: Text.AlignRight
							//verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap
							maximumLineCount:1

							color: textColor
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
				}
			}
			Component.onCompleted: {
					changeLanguage();					
			}
			
			MouseArea {
				anchors.fill: settingsButton2
				hoverEnabled: true
				onClicked: {
					collectionPane.visible= false;
					settingsPane.visible= true;
				}
				onEntered:{
					settingsButton2Circle.color = "gray"
				}
				onExited:{
					settingsButton2Circle.color = white
				}
				onPressed:{
					settingsButton2Circle.color = darkgray
				}
				onReleased:{
					settingsButton2Circle.color = white
				}
			}
			
			Rectangle{
				id: settingsButton2Circle
				anchors.fill: settingsButton2
				width: 30
				height: 30
				radius: width*0.5
				color: white
					
			}
			
			Image {
				id: settingsButton2
				width: 30
				height: 30
				anchors.left: parent.left
				anchors.bottom: parent.bottom
				anchors.bottomMargin: borderSize
				anchors.leftMargin: borderSize
				
				visible: true

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectFit 
				
				asynchronous: true
				source: "assets/btnsettings.png"
				sourceSize { width: 50 ; height: 50 }
			}
				
				

		}
		//settingspane
		Rectangle{
			id: settingsPane
			
			visible: false
			
			anchors.top: parent.top
			anchors.left: parent.left
			height: parent.height
			width: (parent.width/10)*2
			
			color: leftPaneBackground
			
			Image{
				anchors.fill: parent
				
				source: "assets/panebackground.png"
					
				visible: true

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectCrop 
					
				asynchronous: true
				sourceSize { width: parent.width ; height: parent.height }
				
			}
			Item{
				anchors.fill: parent
				
			MouseArea {
				anchors.fill: settingsButton1
				hoverEnabled: true
				onClicked: {
					collectionPane.visible= true;
					settingsPane.visible= false;
				}
				onEntered:{
					settingsButton1Circle.color = "gray"
				}
				onExited:{
					settingsButton1Circle.color = white
				}
				onPressed:{
					settingsButton1Circle.color = darkgray
				}
				onReleased:{
					settingsButton1Circle.color = white
				}
			}
			
			Rectangle{
				id: settingsButton1Circle
				anchors.fill: settingsButton1
				width: 30
				height: 30
				radius: width*0.5
				color: white
					
			}
			Image {
				id: settingsButton1
				width: 30
				height: 30
				anchors.left: parent.left
				anchors.bottom: parent.bottom
				anchors.bottomMargin: borderSize
				anchors.leftMargin: borderSize
				
				visible: true

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectFit 

				asynchronous: true
				source: "assets/btnsettings.png"
				sourceSize { width: 30 ; height: 30 }
			}
				
				Text {
					id: settingsTitle
					text: langSettings

					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					anchors.topMargin: borderSize
					width: parent.width
					height: titleFontSize
					
					// align to the center
					horizontalAlignment: Text.AlignHCenter
					//verticalAlignment: Text.AlignVCenter
					wrapMode: Text.Wrap
					maximumLineCount:1

					// set the font
					color: textColor
					font.pixelSize: titleFontSize
					font.family: globalFonts.sans
					font.bold: true
				}
				Rectangle{
					id: button1
					//leftpanecolor
					anchors.top: settingsTitle.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn1ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeColorLeftPane();
							}onEntered:{
								button1.color = "gray"
							}
							onExited:{
								button1.color = white
							}
							onPressed:{
								button1.color = darkgray
							}
							onReleased:{
								button1.color = white
							}
						}
						Text {
							id: btn1ColorText
							text: langLeftPaneColor

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
				Rectangle{
					id: button2
					//centerpanecolor
					anchors.top: button1.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeColorCenterPane();
							}onEntered:{
								button2.color = "gray"
							}
							onExited:{
								button2.color = white
							}
							onPressed:{
								button2.color = darkgray
							}
							onReleased:{
								button2.color = white
							}
						}
						Text {
							id: btn2ColorText
							text: langCenterPaneColor

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
				Rectangle{
					id: button3
					//rightpanecolor
					anchors.top: button2.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeColorRightPane();
							}onEntered:{
								button3.color = "gray"
							}
							onExited:{
								button3.color = white
							}
							onPressed:{
								button3.color = darkgray
							}
							onReleased:{
								button3.color = white
							}
						}
						Text {
							id: btn3ColorText
							text: langRightPaneColor

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
				Rectangle{
					id: button4
					//highlightcolor
					anchors.top: button3.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeColorHighlight();
							}onEntered:{
								button4.color = "gray"
							}
							onExited:{
								button4.color = white
							}
							onPressed:{
								button4.color = darkgray
							}
							onReleased:{
								button4.color = white
							}
						}
						Text {
							id: btn4ColorText
							text: langHighlight

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
				Rectangle{
					id: button5
					//textColor
					anchors.top: button4.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeColorText();
							}onEntered:{
								button5.color = "gray"
							}
							onExited:{
								button5.color = white
							}
							onPressed:{
								button5.color = darkgray
							}
							onReleased:{
								button5.color = white
							}
						}
						Text {
							id: btn5ColorText
							text: langTextColor

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
				Rectangle{
					id: button6
					//highlightcolor
					anchors.top: button5.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeColorGameBox();
							}onEntered:{
								button6.color = "gray"
							}
							onExited:{
								button6.color = white
							}
							onPressed:{
								button6.color = darkgray
							}
							onReleased:{
								button6.color = white
							}
						}
						Text {
							id: btn6ColorText
							text: langGameBoxColor

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
				Rectangle{
					id: button7
					//highlightcolor
					anchors.top: button6.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								changeLanguageValue();
							}onEntered:{
								button7.color = "gray"
							}
							onExited:{
								button7.color = white
							}
							onPressed:{
								button7.color = darkgray
							}
							onReleased:{
								button7.color = white
							}
						}
						Text {
							id: btn7ColorText
							text: langLang + ": " + langLanguage

													
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: borderSize
							width: parent.width
							
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap

							color: leftPaneBackground
							font.pixelSize: subtitleFontSize
							font.family: globalFonts.sans
						}
					}
				}
			}
		}
		//centerpane	
		Rectangle{
			id: gamesPane
			
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: (parent.width/10)*5
			anchors.leftMargin: (parent.width/10)*2
			
			color: centerPaneBackground
			
			GridView{
				id: grid
				anchors.fill: parent
				anchors.leftMargin: (parent.width%cellWidth)/2 
				
				model: collectionData.games
				
				delegate: gridDelegate
				
				cellWidth: 180 + spaceBetweenGames
				cellHeight: 200 + spaceBetweenGames + 60
				
				keyNavigationEnabled: false
				keyNavigationWraps: true
				
				highlightRangeMode: GridView.StrictlyEnforceRange 
				highlight: highlight
				highlightFollowsCurrentItem: true
				snapMode: GridView.SnapOneRow
				
				focus: true
				
				Keys.onPressed: {
					if (api.keys.isAccept(event)) {
						event.accepted = true;
						collectionData.games.get(grid.currentIndex).launch();
					}
					if (api.keys.isPrevPage(event)) {
						collectionValue = collectionValue -1;
						leftPaneListView.decrementCurrentIndex();
						if(collectionValue<0){
							collectionValue = api.collections.count-1;
							while(leftPaneListView.currentIndex<leftPaneListView.count-1){
								leftPaneListView.incrementCurrentIndex();
							}
						}
						collectionData = api.collections.get(collectionValue);
						
					}
					if (api.keys.isNextPage(event)) {
						collectionValue = collectionValue +1;
						leftPaneListView.incrementCurrentIndex();
						if(collectionValue==api.collections.count){
							collectionValue = 0;
							while(leftPaneListView.currentIndex>0){
								leftPaneListView.decrementCurrentIndex();
							}
						}
						collectionData = api.collections.get(collectionValue);
						
					}
					if (event.key == Qt.Key_Up ){
						grid.moveCurrentIndexUp()
					}
					if (event.key == Qt.Key_Down){
						grid.moveCurrentIndexDown()
					}
					if (event.key == Qt.Key_Left ){
						grid.moveCurrentIndexLeft()
					}
					if (event.key == Qt.Key_Right){
						grid;moveCurrentIndexRight()
					}
				}
				
				
			}
			
			
			Rectangle{
				id: highlight
				//anchors.fill: parent
				//anchors.top: grid.currentItem * grid.cellHeight
				//anchors.left: grid.currentItem * grid.cellWidth
				x: grid.currentItem.x + ((parent.width%grid.cellWidth)/2)
				y: grid.itemAtIndex(grid.currentIndex).y
				
				height: grid.cellHeight - spaceBetweenGames + borderSize
				width: grid.cellWidth - spaceBetweenGames + borderSize
				
				color: "transparent"
				border.color: highlightColor
				border.width: borderSize
						
				Behavior on x { SmoothedAnimation { duration: 150 } }
				Behavior on y { SmoothedAnimation { duration: 150 } }
			}
			
			
			Component{
				id: gridDelegate
				
				Item{
					
					Rectangle {
						anchors.left: parent.left
						anchors.leftMargin: borderSize
						anchors.top: parent.top
						anchors.topMargin: borderSize
						
						width: grid.cellWidth - spaceBetweenGames - borderSize
						height: grid.cellHeight - spaceBetweenGames - borderSize
												
						color:  "transparent"
						
						Rectangle{
							anchors.fill: parent
							
							color: gameBoxBackgroundColor
						}
						
						Rectangle{
							color: "transparent"
							
							anchors.top: parent.top
							anchors.topMargin: parent.height - 70 + (borderSize*2)
							anchors.left: parent.left
							anchors.leftMargin: borderSize
							anchors.right: parent.right
							anchors.rightMargin: borderSize
							anchors.bottom: parent.bottom
						
							Text {
								text: modelData.title 
																						
								anchors.fill: parent
								anchors.leftMargin: borderSize
								anchors.rightMargin: borderSize

								horizontalAlignment: Text.AlignLeft
								verticalAlignment: Text.AlignTop
								
								
								wrapMode: Text.Wrap							
								maximumLineCount: 2
								
								color: textColor
								font.pixelSize: subtitleFontSize
								font.family: globalFonts.sans
							}
							
							Text {
								text: modelData.developer 
								
															
								anchors.fill: parent
								anchors.leftMargin: borderSize
								anchors.rightMargin: borderSize
								anchors.bottomMargin: borderSize

								horizontalAlignment: Text.AlignLeft
								verticalAlignment: Text.AlignBottom
								
								wrapMode: Text.Wrap							
								maximumLineCount: 1
								
								// set the font
								color: textColor
								font.pixelSize: fontSize
								font.family: globalFonts.sans
							}
						}
						Image {
							id: gameBox

							width: parent.width - (borderSize*2)
							height: parent.height - 70
							
							anchors.left: parent.left
							anchors.leftMargin: (borderSize)
							anchors.top: parent.top
							anchors.topMargin: borderSize
							
							visible: source

							// fill the whole area, cropping what lies outside
							fillMode: Image.PreserveAspectFit 

							asynchronous: true
							source: assets.boxFront || assets.poster || assets.cartridge
							sourceSize { width: parent.width - (borderSize*2) ; height: parent.height - 70 }
						}
						
					}
				


				}
			}
			
			Rectangle{
				id: rightPaneButton
				
				width: 30
				height: 30
				
				anchors.right: parent.right
				anchors.top: parent.top
				
				color: rightPaneBackground
				radius: 8
				
				Rectangle{
					id: rightPaneButtonBorder
					
					width: 10
					height: 30
					
					anchors.right: parent.right
					
					color: rightPaneBackground
				}
				MouseArea {
					anchors.fill: rightPaneButton
					hoverEnabled: true
					onClicked: {
						if(isRightPanelOpen){
							detailsPane.visible= false;
							detailsPane.width= 0;
							gamesPane.width = (root.width/10)*8;
							rightPaneButtonImage.source= "assets/paneleft.png"
							isRightPanelOpen = false;
						}
						else{
							detailsPane.visible= true;
							detailsPane.width= (root.width/10)*3;
							gamesPane.width = (root.width/10)*5;
							rightPaneButtonImage.source= "assets/paneright.png"
							isRightPanelOpen = true;
						}
					}
					onEntered:{
						rightPaneButtonBorder.color = "gray"
						rightPaneButton.color = "gray"
					}
					onExited:{
						rightPaneButtonBorder.color = rightPaneBackground
						rightPaneButton.color = rightPaneBackground
					}
					onPressed:{
						rightPaneButtonBorder.color = darkgray
						rightPaneButton.color = darkgray
					}
					onReleased:{
						rightPaneButtonBorder.color = rightPaneBackground
						rightPaneButton.color = rightPaneBackground
					}
				}
				Image {
					id: rightPaneButtonImage
					
					width: 30
					height: 30
					
					anchors.right: parent.right
					anchors.top: parent.top
					
					visible: source

					// fill the whole area, cropping what lies outside
					fillMode: Image.PreserveAspectFit 
					
					asynchronous: true
					source: "assets/paneright.png"
					sourceSize { width: 50 ; height: 50 }
				}
			}
		}
		//rightpane
		Rectangle{
			id: detailsPane
			
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: (parent.width/10)*3
			anchors.leftMargin: (parent.width/10)*7
			
			color: rightPaneBackground
			
			Image{
				anchors.fill: parent
				
				source: "assets/panebackgroundright.png"
					
				visible: true

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectCrop 
					
				asynchronous: true
				sourceSize { width: parent.width ; height: parent.height }
				
			}
				
			Image {
				id: gameImage

				width: parent.width
				height: (parent.height/5)*2
				
				anchors.left: parent.left
				anchors.top: parent.top
				
				visible: source

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectFit

				asynchronous: true
				source: collectionData.games.get(grid.currentIndex).assets.screenshots[0] || collectionData.games.get(grid.currentIndex).assets.banner || collectionData.games.get(grid.currentIndex).assets.steam
			}
			
			Text {
				id: gameTitle
				text: collectionData.games.get(grid.currentIndex).title
				
				anchors.top: parent.top
				anchors.topMargin: gameImage.height + borderSize
				anchors.left: parent.left
				anchors.leftMargin: borderSize
				anchors.right: parent.right
				anchors.rightMargin: borderSize
				
				height: titleFontSize*2

				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				wrapMode: Text.Wrap
				maximumLineCount: 2

				color: textColor
				font.pixelSize: titleFontSize
				font.family: globalFonts.sans
				font.bold: true
				
			}
			
			Text {
				id: gameYear
				text: collectionData.games.get(grid.currentIndex).releaseYear
						
				
				anchors.top: gameTitle.bottom
				anchors.topMargin: borderSize
				anchors.left: parent.left
				anchors.right: parent.right
				
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
			}
			
			Text {
				id: gameDetails
				text: "\n" + langDeveloper + ": " + collectionData.games.get(grid.currentIndex).developer + "\n" + 
						langGenre + ": " + collectionData.games.get(grid.currentIndex).genre
				
				anchors.top: gameYear.bottom
				anchors.left: parent.left
				anchors.leftMargin: borderSize*4
				width: parent.width/2
				
				horizontalAlignment: Text.AlignLeft
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
			}
			
			Text {
				
				text: langPublisher + ": " + collectionData.games.get(grid.currentIndex).publisher + "\n" +
					  langPlayers + ": " + collectionData.games.get(grid.currentIndex).players
						
				
				anchors.top: gameDetails.top
				anchors.topMargin: borderSize*3
				anchors.left: gameDetails.right
				anchors.right: parent.right
				anchors.rightMargin: borderSize*4
				
				horizontalAlignment: Text.AlignLeft
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
			}
			
			
			Text {
				id: description
				text: collectionData.games.get(grid.currentIndex).summary || collectionData.games.get(grid.currentIndex).description
				
				
				anchors.top: gameDetails.bottom
				anchors.topMargin: borderSize*2
				anchors.left: parent.left
				anchors.leftMargin: borderSize*4
				anchors.right: parent.right
				anchors.rightMargin: borderSize*4
				
				horizontalAlignment: Text.AlignJustify
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
				

			}
			
				
		}
	}
	//functions
	function changeColorCenterPane(){
		centerPaneColorValue = centerPaneColorValue + 1
		if (centerPaneColorValue>19){
			centerPaneColorValue = 0
		}
		switch(centerPaneColorValue){
			case 0:
				centerPaneBackground = lightgreen;
				break;
			case 1:
				centerPaneBackground = green;
				break;
			case 2:
				centerPaneBackground = darkgreen;
				break;
			case 3:
				centerPaneBackground = lightblue;
				break;
			case 4:
				centerPaneBackground = blue;
				break;
			case 5:
				centerPaneBackground = darkblue;
				break;
			case 6:
				centerPaneBackground = lightpink;
				break;
			case 7:
				centerPaneBackground = pink;
				break;
			case 8:
				centerPaneBackground = purple;
				break;
			case 9:
				centerPaneBackground = lightyellow;
				break;
			case 10:
				centerPaneBackground = yellow;
				break;
			case 11:
				centerPaneBackground = darkyellow;
				break;	
			case 12:
				centerPaneBackground = orange;
				break;
			case 13:
				centerPaneBackground = lightred;
				break;
			case 14:
				centerPaneBackground = red;
				break;
			case 15:
				centerPaneBackground = darkred;
				break;
			case 16:
				centerPaneBackground = "gray";
				break;
			case 17:
				centerPaneBackground = darkgray;
				break;
			case 18:
				centerPaneBackground = "black";
				break;
				
		}
	}
	function changeColorLeftPane(){
		leftPaneColorValue = leftPaneColorValue + 1
		if (leftPaneColorValue>19){
			leftPaneColorValue = 0
		}
		switch(leftPaneColorValue){
			case 0:
				leftPaneBackground = lightgreen;
				break;
			case 1:
				leftPaneBackground = green;
				break;
			case 2:
				leftPaneBackground = darkgreen;
				break;
			case 3:
				leftPaneBackground = lightblue;
				break;
			case 4:
				leftPaneBackground = blue;
				break;
			case 5:
				leftPaneBackground = darkblue;
				break;
			case 6:
				leftPaneBackground = lightpink;
				break;
			case 7:
				leftPaneBackground = pink;
				break;
			case 8:
				leftPaneBackground = purple;
				break;
			case 9:
				leftPaneBackground = lightyellow;
				break;
			case 10:
				leftPaneBackground = yellow;
				break;
			case 11:
				leftPaneBackground = darkyellow;
				break;	
			case 12:
				leftPaneBackground = orange;
				break;
			case 13:
				leftPaneBackground = lightred;
				break;
			case 14:
				leftPaneBackground = red;
				break;
			case 15:
				leftPaneBackground = darkred;
				break;
			case 16:
				leftPaneBackground = "gray";
				break;
			case 17:
				leftPaneBackground = darkgray;
				break;
			case 18:
				leftPaneBackground = "black";
				break;
			case 19:
				leftPaneBackground = "white";
				break;				
		}
	}
	function changeColorRightPane(){
		rightPaneColorValue = rightPaneColorValue + 1
		if (rightPaneColorValue>19){
			rightPaneColorValue = 0
		}
		switch(rightPaneColorValue){
			case 0:
				rightPaneBackground = lightgreen;
				break;
			case 1:
				rightPaneBackground = green;
				break;
			case 2:
				rightPaneBackground = darkgreen;
				break;
			case 3:
				rightPaneBackground = lightblue;
				break;
			case 4:
				rightPaneBackground = blue;
				break;
			case 5:
				rightPaneBackground = darkblue;
				break;
			case 6:
				rightPaneBackground = lightpink;
				break;
			case 7:
				rightPaneBackground = pink;
				break;
			case 8:
				rightPaneBackground = purple;
				break;
			case 9:
				rightPaneBackground = lightyellow;
				break;
			case 10:
				rightPaneBackground = yellow;
				break;
			case 11:
				rightPaneBackground = darkyellow;
				break;	
			case 12:
				rightPaneBackground = orange;
				break;
			case 13:
				rightPaneBackground = lightred;
				break;
			case 14:
				rightPaneBackground = red;
				break;
			case 15:
				rightPaneBackground = darkred;
				break;
			case 16:
				rightPaneBackground = "gray";
				break;
			case 17:
				rightPaneBackground = darkgray;
				break;
			case 18:
				rightPaneBackground = "black";
				break;
			case 19:
				rightPaneBackground = "white";
				break;
				
		}
	}
	function changeColorHighlight(){
		highlightColorValue = highlightColorValue + 1
		if (highlightColorValue>19){
			highlightColorValue = 0
		}
		switch(highlightColorValue){
			case 0:
				highlightColor = lightgreen;
				break;
			case 1:
				highlightColor = green;
				break;
			case 2:
				highlightColor = darkgreen;
				break;
			case 3:
				highlightColor = lightblue;
				break;
			case 4:
				highlightColor = blue;
				break;
			case 5:
				highlightColor = darkblue;
				break;
			case 6:
				highlightColor = lightpink;
				break;
			case 7:
				highlightColor = pink;
				break;
			case 8:
				highlightColor = purple;
				break;
			case 9:
				highlightColor = lightyellow;
				break;
			case 10:
				highlightColor = yellow;
				break;
			case 11:
				highlightColor = darkyellow;
				break;	
			case 12:
				highlightColor = orange;
				break;
			case 13:
				highlightColor = lightred;
				break;
			case 14:
				highlightColor = red;
				break;
			case 15:
				highlightColor = darkred;
				break;
			case 16:
				highlightColor = "gray";
				break;
			case 17:
				highlightColor = darkgray;
				break;
			case 18:
				highlightColor = "black";
				break;
			case 19:
				highlightColor = "white";
				break;
				
		}
	}
	function changeColorGameBox(){
		gameboxColorValue = gameboxColorValue + 1
		if (gameboxColorValue>19){
			gameboxColorValue = 0
		}
		switch(gameboxColorValue){
			case 0:
				gameBoxBackgroundColor = lightgreen;
				break;
			case 1:
				gameBoxBackgroundColor = green;
				break;
			case 2:
				gameBoxBackgroundColor = darkgreen;
				break;
			case 3:
				gameBoxBackgroundColor = lightblue;
				break;
			case 4:
				gameBoxBackgroundColor = blue;
				break;
			case 5:
				gameBoxBackgroundColor = darkblue;
				break;
			case 6:
				gameBoxBackgroundColor = lightpink;
				break;
			case 7:
				gameBoxBackgroundColor = pink;
				break;
			case 8:
				gameBoxBackgroundColor = purple;
				break;
			case 9:
				gameBoxBackgroundColor = lightyellow;
				break;
			case 10:
				gameBoxBackgroundColor = yellow;
				break;
			case 11:
				gameBoxBackgroundColor = darkyellow;
				break;	
			case 12:
				gameBoxBackgroundColor = orange;
				break;
			case 13:
				gameBoxBackgroundColor = lightred;
				break;
			case 14:
				gameBoxBackgroundColor = red;
				break;
			case 15:
				gameBoxBackgroundColor = darkred;
				break;
			case 16:
				gameBoxBackgroundColor = "gray";
				break;
			case 17:
				gameBoxBackgroundColor = darkgray;
				break;
			case 18:
				gameBoxBackgroundColor = "black";
				break;
			case 19:
				gameBoxBackgroundColor = "white";
				break;
				
		}
	}
	function changeColorText(){
		textColorValue = textColorValue + 1
		if (textColorValue>19){
			textColorValue = 0
		}
		switch(textColorValue){
			case 0:
				textColor = lightgreen;
				break;
			case 1:
				textColor = green;
				break;
			case 2:
				textColor = darkgreen;
				break;
			case 3:
				textColor = lightblue;
				break;
			case 4:
				textColor = blue;
				break;
			case 5:
				textColor = darkblue;
				break;
			case 6:
				textColor = lightpink;
				break;
			case 7:
				textColor = pink;
				break;
			case 8:
				textColor = purple;
				break;
			case 9:
				textColor = lightyellow;
				break;
			case 10:
				textColor = yellow;
				break;
			case 11:
				textColor = darkyellow;
				break;	
			case 12:
				textColor = orange;
				break;
			case 13:
				textColor = lightred;
				break;
			case 14:
				textColor = red;
				break;
			case 15:
				textColor = darkred;
				break;
			case 16:
				textColor = "gray";
				break;
			case 17:
				textColor = darkgray;
				break;
			case 18:
				textColor = "black";
				break;
			case 19:
				textColor = "white";
				break;
				
		}
	}
	function changeLanguageValue(){
		languageValue = languageValue + 1;
		if(languageValue>1){
			languageValue = 0;
		}
		changeLanguage();
	}
	function changeLanguage(){
		switch(languageValue){
			case 0:
				langCollections= "Collections"
				langSettings= "Settings";
				langCenterPaneColor= "Center pane color";
				langLeftPaneColor= "Left pane color"
				langRightPaneColor= "Right pane color"
				langHighlight= "Highlight color"
				langTextColor= "Text color"
				langDeveloper= "Developer"
				langGenre= "Genre"
				langPlayers= "Players"
				langPublisher= "Publisher"
				langLanguage= "English"
				langLang= "Language"
				break;
			case 1:
				langCollections= "Coleções"
				langSettings= "Configurações";
				langCenterPaneColor= "Cor do painel central";
				langLeftPaneColor= "Cor do painel esquerdo"
				langRightPaneColor= "Cor do painel direito"
				langHighlight= "Cor de realce"
				langTextColor= "Cor do texto"
				langDeveloper= "Produtora"
				langGenre= "Gênero"
				langPlayers= "Jogadores"
				langPublisher= "Editora"
				langLanguage= "Português"
				langLang= "Idioma"
				break;
		}
	}
}