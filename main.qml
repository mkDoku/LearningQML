//import related modules
import QtQuick 2.12
import QtQuick.Controls 2.12

//window containing the application
ApplicationWindow {
  id: root
  visible: true

  //title of the application
  title: qsTr("LearningQML")
  width: 1280
  height: 960

  signal passText(string myText)

  menuBar: MenuBar {
    Menu {
      title: qsTr("&File")
      Action {
        text: qsTr("&New...")
      }
      MenuSeparator {}
      Action {
        text: qsTr("&Quit")
      }
    }
  }

  Column {
    spacing: 20

    Row {
      spacing: 6
      height: 400

      Item {
        width: 40
        height: 40

        CheckBox {
          id: box
          checked: false
          onClicked: checked ? passText("Checked") : passText("Unchecked")
          width: parent.width
          height: parent.height
        }
      }

      Item {
        width: 100
        height: box.height

        Rectangle {
          id: rec
          color: "green"
          opacity: 0.6
          radius: 8
          anchors.fill: parent

          TextEdit {
            id: txt
            color: "blue"
            text: "Unchecked"
            readOnly: true
            selectByMouse: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Component.onCompleted: {
              root.passText.connect(onPassText)
            }

            function onPassText(myText) {
              text = myText

              if (myText === "Unchecked") {
                txt.rotation = 0
              } else {
                txt.rotation = 180
              }
            }
          }
        }
        //      TextField {
        //        id: txt
        //        color: "blue"
        //        text: "Unchecked"
        //        readOnly: true
        //        selectByMouse: true
        //        background: rec
        //        anchors.fill: parent
        //        horizontalAlignment: TextEdit.AlignHCenter
        //        Component.onCompleted: {
        //          root.passText.connect(onPassText)
        //        }
        //        function onPassText(myText) {
        //          text = myText
        //        }
        //      }
      }

      Item {
        width: 100
        height: 100
        Rectangle {
          id: aniRec
          anchors.fill: parent
          color: "green"
          ScaleAnimator {
            target: aniRec
            loops: Animation.Infinite
            from: 0
            to: 1
            duration: 1000
            running: true
          }
        }
      }

      Item {
        width: 200
        height: 200

        Rectangle {
          anchors.fill: parent
          id: signal
          state: "NORMAL"

          states: [
            State {
              name: "NORMAL"
              PropertyChanges {
                target: signal
                color: "green"
              }

              //            PropertyChanges {
              //              target: flag
              //              state: "FLAG_DOWN"
              //            }
            },

            State {

              name: "CRITICAL"
              PropertyChanges {
                target: signal
                color: "red"
              }

              //            PropertyChanges {
              //              target: flag
              //              state: "FLAG_UP"
              //            }
            }
          ]
        }

        Rectangle {
          id: signalswitch

          //        x: (parent.width - width) / 2
          //        y: (parent.height - height) / 2
          anchors.horizontalCenter: signal.horizontalCenter
          anchors.verticalCenter: signal.verticalCenter

          width: 75
          height: 75
          color: "blue"

          MouseArea {
            anchors.fill: parent
            onClicked: {

              if (signal.state === "NORMAL")
                signal.state = "CRITICAL"
              else
                signal.state = "NORMAL"
            }
          }
        }
      }

      Item {
        width: 400
        height: parent.height

        Rectangle {
          id: rect
          width: 200
          height: 100

          color: "red"

          states: [
            State {
              name: "rotated"
              PropertyChanges {
                target: rect
                rotation: 180
                transformOrigin: Item.BottomRight
              }
            },

            State {
              name: "rotateBack"
              PropertyChanges {
                target: rect
                rotation: 360
                transformOrigin: Item.BottomRight
              }
            }
          ]

          //        transitions: Transition {
          //          RotationAnimation {
          //            duration: 1000
          //            direction: RotationAnimation.Clockwise
          //          }
          //        }
          transitions: [
            Transition {
              SequentialAnimation {
                PropertyAction {
                  target: rect
                  property: "transformOrigin"
                }
                RotationAnimation {
                  duration: 1000
                  direction: RotationAnimation.Counterclockwise
                }
              }
            }
          ]

          MouseArea {
            anchors.fill: parent
            onClicked: (rect.state === "" || rect.state
                        === "rotateBack") ? rect.state = "rotated" : rect.state = "rotateBack"
          }
        }
      }

      Item {
        width: 200
        height: parent.height

        Rectangle {
          anchors.fill: parent
          color: "Blue"
          radius: 8
        }

        Text {
          anchors.fill: parent
          // For text to wrap, a width has to be explicitly provided

          // This setting makes the text wrap at word boundaries when it goes
          // past the width of the Text object
          wrapMode: Text.WordWrap
          padding: 10

          // You can use \ to escape quotation marks, or to add new lines (\n).
          //  Use \\ to get a \ in the string
          text: 'I am the very model of a modern major general. I\'ve information \
vegetable, animal and mineral. I know the kings of england and I \
quote the fights historical; from Marathon to Waterloo in order categorical.'

          // color can be set on the entire element with this property
          color: "white"
        }
      }
    }

    // ------------------------------------- //
    Row {
      spacing: 6
      height: 400

      Item {
        width: 200
        height: parent.height
        // Model //
        ListModel {
          id: nameModel
          ListElement {
            name: "Alice Schwarzer"
            wat: "XX"
          }
          ListElement {
            name: "Bob Marley"
            wat: "XY"
          }
          ListElement {
            name: "Jane Austen"
            wat: "XX"
          }
          ListElement {
            name: "Harry Potter"
            wat: "XY"
          }
          ListElement {
            name: "This is a Wendy's, Sir!"
            wat: "Message"
          }
        }
        // Delegate //
        Component {
          id: nameDelegate

          Text {
            // set width explicitly, else the highlight
            // would shrink
            width: parent.width
            text: name
            color: "Teal"
            font.pixelSize: 20
          }
        }

        ListView {
          anchors.fill: parent
          clip: true
          model: nameModel
          delegate: nameDelegate
          header: bannercomponent
          footer: Rectangle {
            width: parent.width
            height: 12
            gradient: clubcolors
          }
          highlight: Rectangle {
            //            width: parent.width
            width: parent.width
            color: "lightgray"
          }
          section {
            property: "wat"
            criteria: ViewSection.FullString
            delegate: Rectangle {
              color: "#b0dfb0"
              width: parent.width
              height: childrenRect.height + 4
              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
                font.bold: true
                text: section
              }
            }
          }
        }

        Component {
          //instantiated when header is processed
          id: bannercomponent
          Rectangle {
            id: banner
            width: parent.width
            height: 40
            gradient: clubcolors
            border {
              color: "#9EDDF2"
              width: 2
            }
            Text {
              anchors.centerIn: parent
              text: "Club Members"
              font.pixelSize: 24
            }
          }
        }
        Gradient {
          id: clubcolors
          GradientStop {
            position: 0.0
            color: "#8EE2FE"
          }
          GradientStop {
            position: 0.5
            color: "#DDFFDD"
          }
        }
      }

      ListModel {
        id: contactModel

        ListElement {
          name: "Bill Smith"
          number: "555 3264"
        }
        ListElement {
          name: "John Brown"
          number: "555 8426"
        }
        ListElement {
          name: "Sam Wise"
          number: "555 0473"
        }
        ListElement {
          name: "Bill Smith"
          number: "555 3264"
        }
        ListElement {
          name: "John Brown"
          number: "555 8426"
        }
        ListElement {
          name: "Sam Wise"
          number: "555 0473"
        }
        ListElement {
          name: "Bill Smith"
          number: "555 3264"
        }
        ListElement {
          name: "John Brown"
          number: "555 8426"
        }
        ListElement {
          name: "Sam Wise"
          number: "555 0473"
        }
      }

      //      ScrollView {
      //        id: scrollView

      //        Column {

      //          ListView {
      //            width: 180
      //            height: 100

      //            model: contactModel
      //            delegate: Text {
      //              font.pixelSize: 20
      //              text: name + ": " + number
      //            }
      //          }
      //        }
      //      }

      // https://www.youtube.com/watch?v=qzSNju-h1pk
      Rectangle {
        width: 400
        height: 200
        color: "lightblue"

        LineEdit {
          id: lineEdit
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
          anchors.topMargin: 16
        }

        Text {
          anchors.top: lineEdit.bottom
          anchors.topMargin: 12
          anchors.left: parent.left
          anchors.leftMargin: 16
          text: "<b>Summary:</b> " + lineEdit.text
        }
      }

      Item {
        width: 400
        height: parent.height

        Rectangle {
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.bottom: parent.verticalCenter
          color: "lightblue"

          CheckBoxSignal {
            anchors.centerIn: parent
            onChecked: checkValue ? parent.color = "red"
                                  : parent.color = "lightblue"
          }
        }

        Rectangle {
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.verticalCenter
          anchors.bottom: parent.bottom

          color: checkBoxBetter.checked ? "red" : "lightblue"

          CheckBoxBetter {
            id: checkBoxBetter
            anchors.centerIn: parent

            checked: false
          }
        }
      }
    }
  }
}
