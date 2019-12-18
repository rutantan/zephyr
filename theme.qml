import QtQuick 2.12
import SortFilterProxyModel 0.2

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
	
	//color variables
	property var textColor: white
	property var highlightColor: white
	property var centerPaneBackground: "black"
	property var leftPaneBackground: blue
	property var rightPaneBackground: blue
	property var gameBoxBackgroundColor: darkgray
	
	//current index values
	property int highlightColorValue: 17;
	property int leftPaneColorValue: 17;
	property int backgroundColorValue: 3;
	property int rightPaneColorValue: 17;
	property int gameboxColorValue: 18;
	property int textColorValue: 17;
	property int sorterValue: 0;
	property int languageValue: 0;
	property int backgroundValue: 2;
	
	property var collectionData: api.collections.get(0);
	
	//border and spaces
	property int spaceBetweenGames: vpx(10); 
	property int borderSize: vpx(5);
	
	//font sizes
	property int titleFontSize: vpx(30);
	property int subtitleFontSize: vpx(18);
	property int fontSize: vpx(16);
	property int detailsFontSize: vpx(18);
	property int collectionFontSize: vpx(24);
	
	property bool isRightPanelOpen: true;
	property bool isAscendingOrder: true;

	//language variables
	property var langCollections: "Collections"
	property var langSettings: "Settings"
	property var langBackgroundColor: "Background color"
	property var langLeftPaneColor: "Left pane color"
	property var langRightPaneColor: "Right pane color"
	property var langTextColor: "Text color"
	property var langGameBoxColor: "Game box color"
	property var langYear: "Year"
	property var langDeveloper: "Developer"
	property var langGenre: "Genre"
	property var langPlayers: "Players"
	property var langPublisher: "Publisher"
	property var langHighlight: "Highlight color"
	property var langPlayCount: "Times played"
	property var langSorter: "Name"
	property var langBackgroundImage: "Background image"
	property var langPlayTime: "Time played"
	property var langLanguage: "English"
	property var langLang: "Language"
	
	//text variables
	property var backgroundImageSource: "assets/panebackground2.png"
	
	//root
	Rectangle{
		id: root
		anchors.fill: parent
		color: centerPaneBackground
		//backgroundImage
		Image{
			id: backgroundImage
				anchors.fill: parent
				
				source: backgroundImageSource
					
				visible: true

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectCrop 
					
				asynchronous: true
				sourceSize { width: parent.width ; height: parent.height }
				
			}
		//centerpane
		Rectangle{
			id: gamesPane
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: ((parent.width/10)*5)
			anchors.leftMargin: (parent.width/10)*2
			
			color: "transparent"
			
			GridView {
				id: grid
				anchors.fill: parent
				anchors.leftMargin: ((parent.width%cellWidth)/2) 
				model: collectionData.games
				
				delegate: gridDelegate
				
				cellWidth: vpx(180) + spaceBetweenGames
				cellHeight: vpx(220) + spaceBetweenGames + (subtitleFontSize*2)
				
				keyNavigationEnabled: false
				keyNavigationWraps: true
				
				highlightRangeMode: GridView.StrictlyEnforceRange 
				snapMode: GridView.SnapOneRow
				
				focus: true
				
				Keys.onPressed: {
					if (api.keys.isAccept(event)) {
						event.accepted = true;
						collectionData.games.get(grid.currentIndex).launch();
					}
					if (api.keys.isPrevPage(event)) {
						if(leftPaneListView.currentIndex==0){
							while(leftPaneListView.currentIndex<api.collections.count-1){
								leftPaneListView.incrementCurrentIndex();
							}
						}
						else{
							leftPaneListView.decrementCurrentIndex()
						}
						collectionData = api.collections.get(leftPaneListView.currentIndex)
						
					}
					if (api.keys.isNextPage(event)) {
						if(leftPaneListView.currentIndex==(api.collections.count-1)){
							while(leftPaneListView.currentIndex>0){
								leftPaneListView.decrementCurrentIndex();
							}
						}
						else{
							leftPaneListView.incrementCurrentIndex()
						}
						collectionData = api.collections.get(leftPaneListView.currentIndex)
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
						grid.moveCurrentIndexRight()
					}
				}
				
				
			}
			//gameHighlight
			Rectangle{
				id: highlight
				
				x: grid.currentItem.x + ((parent.width%grid.cellWidth)/2)
				
				height: grid.cellHeight - spaceBetweenGames + borderSize
				width: grid.cellWidth - spaceBetweenGames + borderSize
				
				color: "transparent"
				border.color: highlightColor
				border.width: borderSize
				radius: 8
						
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
							radius: 5
							opacity: 0.8
						}
						//gameBox
						Image {
							id: gameBox

							width: vpx(180) - (borderSize*3)
							height: vpx(220) - (subtitleFontSize*2)
							
							anchors.left: parent.left
							anchors.leftMargin: borderSize
							anchors.top: parent.top
							anchors.topMargin: borderSize
							
							visible: source

							// fill the whole area, cropping what lies outside
							fillMode: Image.PreserveAspectFit 

							asynchronous: true
							source: assets.boxFront || assets.poster || assets.cartridge
							sourceSize { height: vpx(220) - (subtitleFontSize*2) - (borderSize*2); width: vpx(180) - borderSize}
						}
						
						Rectangle{
							color: "transparent"
							
							anchors.top: parent.top
							anchors.topMargin: gameBox.height + (borderSize*2)
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
						}
						
						
					}
					MouseArea {
						anchors.fill: parent
						onClicked: grid.currentIndex = index
					}				
				}
			}
		}
		// leftpane		
		Rectangle{
			id: collectionPane
			
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			
			height: parent.height
			width: (parent.width/10)*2
			
			color: "transparent"
			visible: true
			//background
			Rectangle{
				anchors.fill: parent
				color: leftPaneBackground
				opacity: 0.8
				
			}			
			//collectionTitle
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
			//left Pane ListView
			ListView {
				id: leftPaneListView
				
				anchors.top: collectionTitle.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.bottom: parent.bottom
				anchors.leftMargin: borderSize*2
				anchors.topMargin: borderSize*4
				anchors.rightMargin: borderSize*2
				anchors.bottomMargin: borderSize*2 + 30 //because of settingsButton1

				model: api.collections
				
				delegate: leftPaneDelegate
				
				spacing: borderSize*7 //space between items
			}
			
			Rectangle{
				id: highlightLeftPane
				//anchors.fill: parent
				//anchors.top: parent.top
				//anchors.left: parent.left
				
				
				x: leftPaneListView.currentItem.x 
				y: leftPaneListView.currentItem.y + (borderSize*5) + titleFontSize
				
				
				height: collectionFontSize + borderSize
				width: parent.width
				
				color: centerPaneBackground
				border.color: centerPaneBackground
				border.width: borderSize
						
				Behavior on x { SmoothedAnimation { duration: 150 } }
				Behavior on y { SmoothedAnimation { duration: 150 } }
				
				
				Text {
					
					text: {
						if (api.collections.get(leftPaneListView.currentIndex).name == "Super Nintendo Entertainment System")
							"Super NES"
						else if (api.collections.get(leftPaneListView.currentIndex).name == "Nintendo Entertainment System")
							"NES"
						else if (api.collections.get(leftPaneListView.currentIndex).name == "Nintendo Game Boy Advance")
							"Nintendo GBA" 
						else if (api.collections.get(leftPaneListView.currentIndex).name == "Nintendo Game Boy Color")
							"Nintendo GBC"
						else if (api.collections.get(leftPaneListView.currentIndex).name == "Nintendo - Nintendo DS")
							"Nintendo DS"
						else
							api.collections.get(leftPaneListView.currentIndex).name
						}

											
					anchors.fill: parent
					anchors.leftMargin: borderSize*2
					
					width: parent.width - 30
					height: collectionFontSize
					
					// align to the center
					//horizontalAlignment: Text.AlignHCenter
					//verticalAlignment: Text.AlignVCenter
					wrapMode: Text.Wrap
					maximumLineCount:1

					color: textColor
					font.pixelSize: collectionFontSize
					font.family: globalFonts.sans
					font.bold: true
				}
				Text{
					text: {
						if(api.collections.get(leftPaneListView.currentIndex).games.count>9999)
							"9999"
						else
							api.collections.get(leftPaneListView.currentIndex).games.count
					}		
					
					anchors.fill: parent
					anchors.leftMargin: borderSize*2
					anchors.rightMargin: borderSize*2
					
					width: 20
					height: subtitleFontSize
					
					horizontalAlignment: Text.AlignRight
					//verticalAlignment: Text.AlignVCenter
					wrapMode: Text.Wrap
					maximumLineCount:1

					color: textColor
					font.pixelSize: collectionFontSize
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
							height: collectionFontSize + (borderSize*4)
							
							//horizontalAlignment: Text.AlignHCenter
							//verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap
							maximumLineCount:1

							color: textColor
							font.pixelSize: collectionFontSize
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
							height: collectionFontSize
							
							horizontalAlignment: Text.AlignRight
							//verticalAlignment: Text.AlignVCenter
							wrapMode: Text.Wrap
							maximumLineCount:1

							color: textColor
							font.pixelSize: collectionFontSize
							font.family: globalFonts.sans
						}
				}
			}
			Component.onCompleted: {
					initMemoryValues();
					getValuesFromMemory();
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
				width: vpx(30)
				height: vpx(30)
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
			
			color: "transparent"
			
			Rectangle{
				anchors.fill: parent
				color: leftPaneBackground
				opacity: 0.8
				
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
					width: vpx(30)
					height: vpx(30)
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
				//button1
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								leftPaneColorValue = leftPaneColorValue + 1;
								changeColorLeftPane();
							}onEntered:{
								button1.border.color = "gray"
							}
							onExited:{
								button1.border.color = white
							}
							onPressed:{
								button1.color = "gray"
							}
							onReleased:{
								button1.color = white
							}
						}
						Text {
							id: btn1ColorText
							text: langLeftPaneColor + ": " + leftPaneColorValue

													
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
				//button2
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								backgroundColorValue = backgroundColorValue + 1;
								changeColorCenterPane();
							}onEntered:{
								button2.border.color = "gray"
							}
							onExited:{
								button2.border.color = white
							}
							onPressed:{
								button2.color = "gray"
							}
							onReleased:{
								button2.color = white
							}
						}
						Text {
							id: btn2ColorText
							text: langBackgroundColor + ": " + backgroundColorValue

													
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
				//button3
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								rightPaneColorValue = rightPaneColorValue + 1;
								changeColorRightPane();
							}onEntered:{
								button3.border.color = "gray"
							}
							onExited:{
								button3.border.color = white
							}
							onPressed:{
								button3.color = "gray"
							}
							onReleased:{
								button3.color = white
							}
						}
						Text {
							id: btn3ColorText
							text: langRightPaneColor + ": " + rightPaneColorValue

													
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
				//button4
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								highlightColorValue = highlightColorValue + 1;
								changeColorHighlight();
							}onEntered:{
								button4.border.color = "gray"
							}
							onExited:{
								button4.border.color = white
							}
							onPressed:{
								button4.color = "gray"
							}
							onReleased:{
								button4.color = white
							}
						}
						Text {
							id: btn4ColorText
							text: langHighlight + ": " + highlightColorValue

													
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
				//button5
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								textColorValue = textColorValue + 1;
								changeColorText();
							}onEntered:{
								button5.border.color = "gray"
							}
							onExited:{
								button5.border.color = white
							}
							onPressed:{
								button5.color = "gray"
							}
							onReleased:{
								button5.color = white
							}
						}
						Text {
							id: btn5ColorText
							text: langTextColor + ": " + textColorValue

													
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
				//button6
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								gameboxColorValue = gameboxColorValue + 1;
								changeColorGameBox();
							}onEntered:{
								button6.border.color = "gray"
							}
							onExited:{
								button6.border.color = white
							}
							onPressed:{
								button6.color = "gray"
							}
							onReleased:{
								button6.color = white
							}
						}
						Text {
							id: btn6ColorText
							text: langGameBoxColor + ": " + gameboxColorValue

													
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
				//button7
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
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								backgroundValue = backgroundValue + 1;
								changeBackground();
							}onEntered:{
								button7.border.color = "gray"
							}
							onExited:{
								button7.border.color = white
							}
							onPressed:{
								button7.color = "gray"
							}
							onReleased:{
								button7.color = white
							}
						}
						Text {
							id: btn7ColorText
							text: langBackgroundImage + ": " + backgroundValue

													
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
				//button8
				Rectangle{
					id: button8
					//highlightcolor
					anchors.top: button7.bottom
					anchors.topMargin: borderSize*4
					anchors.left: parent.left
					anchors.leftMargin: borderSize
					width: parent.width - (borderSize*2)
					height: btn2ColorText.height + (borderSize*2)
					
					color: white
					border.width: 3
					border.color: white
					radius: 5
					
					Item{
						anchors.fill: parent
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							onClicked: {
								languageValue = languageValue + 1;
								changeLanguage();
							}onEntered:{
								button8.border.color = "gray"
							}
							onExited:{
								button8.border.color = white
							}
							onPressed:{
								button8.color = "gray"
							}
							onReleased:{
								button8.color = white
							}
						}
						Text {
							id: btn8ColorText
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
		//rightpane
		Rectangle{
			id: detailsPane
			
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			width: (parent.width/10)*3
			anchors.leftMargin: (parent.width/10)*7
			
			color: "transparent"
			visible: true
			
			Rectangle{
				anchors.fill: parent
				color: rightPaneBackground
				opacity: 0.8
				
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
			//gameTitle
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
				font.bold: FALSE
				
			}
			//detailsLine1
			Rectangle{
				id: detailsLine1
				
				anchors.top: gameTitle.bottom
				anchors.topMargin: borderSize*2
				anchors.left: parent.left
				anchors.leftMargin: borderSize*2
				width: parent.width - (borderSize*4)
				height: vpx(2)
				color: textColor
				
			}
			//gameDetailsLeft
			Text {
				id: gameDetails
				text:
					langYear + ": " + collectionData.games.get(grid.currentIndex).releaseYear + "\n" + 
					langDeveloper + ": " + collectionData.games.get(grid.currentIndex).developer + "\n" + 
					langGenre + ": " + collectionData.games.get(grid.currentIndex).genre + "\n" + 
					langPlayCount + ": " + collectionData.games.get(grid.currentIndex).playCount 
				
				anchors.top: detailsLine1.bottom
				anchors.topMargin: borderSize
				anchors.left: parent.left
				anchors.leftMargin: borderSize*2
				width: (parent.width/2) - borderSize
				
				horizontalAlignment: Text.AlignJustify
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
			}
			//gameDetailsRight
			Text {
				
				text: "\n" +
					langPublisher + ": " + collectionData.games.get(grid.currentIndex).publisher + "\n" +
					langPlayers + ": " + collectionData.games.get(grid.currentIndex).players + "\n" +
					langPlayTime + ": " +  collectionData.games.get(grid.currentIndex).playTime
						
				
				anchors.top: detailsLine1.bottom
				anchors.topMargin: borderSize
				anchors.left: gameDetails.right
				anchors.right: parent.right
				anchors.rightMargin: borderSize*2
				
				horizontalAlignment: Text.AlignJustify
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
			}
			//detailsLine2
			Rectangle{
				id: detailsLine2
				
				anchors.top: gameDetails.bottom
				anchors.topMargin: borderSize*2
				anchors.left: parent.left
				anchors.leftMargin: borderSize*2
				width: parent.width - (borderSize*4)
				height: vpx(2)
				color: textColor
				
			}
			//description
			Text {
				id: description
				text: collectionData.games.get(grid.currentIndex).description || collectionData.games.get(grid.currentIndex).summary
				
				
				anchors.top: detailsLine2.bottom
				anchors.topMargin: borderSize
				anchors.left: parent.left
				anchors.leftMargin: borderSize*2
				anchors.right: parent.right
				anchors.rightMargin: borderSize*2
				
				horizontalAlignment: Text.AlignJustify
				verticalAlignment: Text.AlignTop
				wrapMode: Text.Wrap

				color: textColor
				font.pixelSize: detailsFontSize
				font.family: globalFonts.sans
				

			}
			
				
		}
		//rightPaneButton
		Rectangle{
			id: rightPaneButton
			
			width: vpx(30)
			height: vpx(30)
			
			anchors.right: parent.right
			anchors.rightMargin: detailsPane.width 
			anchors.top: parent.top
			
			color: rightPaneBackground
			radius: 5
			opacity: 0.8
			
			MouseArea {
				anchors.fill: rightPaneButton
				hoverEnabled: true
				onClicked: {
					if(isRightPanelOpen){
						detailsPane.visible= false;
						detailsPane.width= 0;
						gamesPane.width = (root.width/10)*7;
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
					rightPaneButton.color = "gray"
				}
				onExited:{
					rightPaneButton.color = rightPaneBackground
				}
				onPressed:{
					rightPaneButton.color = darkgray
				}
				onReleased:{
					rightPaneButton.color = rightPaneBackground
				}
			}
			Image {
				id: rightPaneButtonImage
				
				width: vpx(30)
				height: vpx(30)
				
				anchors.right: parent.right
				anchors.top: parent.top
				
				visible: source

				// fill the whole area, cropping what lies outside
				fillMode: Image.PreserveAspectFit 
				
				asynchronous: true
				source: "assets/paneright.png"
				sourceSize { width: vpx(50) ; height: vpx(50) }
			}
		}
	}
	//functions
	function changeColorCenterPane(){
		if (backgroundColorValue>19){
			backgroundColorValue = 0
		}
		switch(backgroundColorValue){
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
		api.memory.set("backgroundColorValue", backgroundColorValue);
	}
	function changeColorLeftPane(){
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
		api.memory.set("leftPaneColorValue", leftPaneColorValue);
	}
	function changeColorRightPane(){
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
		api.memory.set("rightPaneColorValue", rightPaneColorValue);
	}
	function changeColorHighlight(){
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
		api.memory.set("highlightColorValue", highlightColorValue);
	}
	function changeColorGameBox(){
		if (gameboxColorValue>20){
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
			case 20:
				gameBoxBackgroundColor = "transparent";
				break;
		}
		api.memory.set("gameboxColorValue", gameboxColorValue);
	}
	function changeColorText(){
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
		api.memory.set("textColorValue", textColorValue);
	}
	function changeBackground(){
		if(backgroundValue>2){
			backgroundValue = 0;
		}
		switch(backgroundValue){
			case 0:
				backgroundImageSource = "assets/panebackground0.png"
				break;
			case 1:
				backgroundImageSource = "assets/panebackground1.png"
				break;
			case 2:
				backgroundImageSource = "assets/panebackground2.png"
				break;
		}
		api.memory.set("backgroundValue", backgroundValue);
	}
	function changeLanguage(){
		if(languageValue>1){
			languageValue = 0;
		}
		switch(languageValue){
			case 0:
				langCollections= "Collections"
				langSettings= "Settings";
				langBackgroundColor= "Background color";
				langLeftPaneColor= "Left pane color"
				langRightPaneColor= "Right pane color"
				langHighlight= "Highlight color"
				langTextColor= "Text color"
				langYear= "Year"
				langDeveloper= "Developer"
				langGenre= "Genre"
				langPlayers= "Players"
				langPublisher= "Publisher"
				langPlayCount= "Times played"
				langPlayTime= "Time played"
				langLanguage= "English"
				langLang= "Language"
				break;
			case 1:
				langCollections= "Coleções"
				langSettings= "Configurações";
				langBackgroundColor= "Cor de fundo";
				langLeftPaneColor= "Cor do painel esquerdo"
				langRightPaneColor= "Cor do painel direito"
				langHighlight= "Cor de realce"
				langTextColor= "Cor do texto"
				langYear= "Ano"
				langDeveloper= "Produtora"
				langGenre= "Gênero"
				langPlayers= "Jogadores"
				langPublisher= "Editora"
				langPlayCount= "Vezes jogado"
				langPlayTime= "Tempo jogado"
				langLanguage= "Português"
				langLang= "Idioma"
				break;
		}
		api.memory.set("languageValue", languageValue);
	}
	function initMemoryValues(){
		if(!api.memory.has("highlightColorValue")){
			api.memory.set("highlightColorValue", 19);
		}
		if(!api.memory.has("leftPaneColorValue")){
			api.memory.set("leftPaneColorValue", 17);
		}
		if(!api.memory.has("backgroundColorValue")){
			api.memory.set("backgroundColorValue", 3);
		}
		if(!api.memory.has("rightPaneColorValue")){
			api.memory.set("rightPaneColorValue", 17);
		}
		if(!api.memory.has("gameboxColorValue")){
			api.memory.set("gameboxColorValue", 17);
		}
		if(!api.memory.has("textColorValue")){
			api.memory.set("textColorValue", 19);
		}
		if(!api.memory.has("backgroundValue")){
			api.memory.set("backgroundValue", 2);
		}
		if(!api.memory.has("languageValue")){
			api.memory.set("languageValue", 0);
		}
	}	
	function getValuesFromMemory(){
		highlightColorValue= api.memory.get("highlightColorValue");
		changeColorHighlight();
		leftPaneColorValue= api.memory.get("leftPaneColorValue");
		changeColorLeftPane();
		backgroundColorValue= api.memory.get("backgroundColorValue");
		changeColorCenterPane();
		rightPaneColorValue= api.memory.get("rightPaneColorValue");
		changeColorRightPane();
		gameboxColorValue= api.memory.get("gameboxColorValue");
		changeColorGameBox();
		textColorValue= api.memory.get("textColorValue");
		changeColorText();
		backgroundValue= api.memory.get("backgroundValue");
		changeBackground();
		languageValue= api.memory.get("languageValue");
		changeLanguage();	
	}
}