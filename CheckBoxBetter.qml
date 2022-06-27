import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
  property bool checked: false

  width: textItem.width + radioButton.width
  height: radioButton.height

  RadioButton {
    id: radioButton
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    checked: parent.checked
  }

  Text {
    id: textItem
    anchors.left: radioButton.right
    anchors.leftMargin: 4
    anchors.verticalCenter: radioButton.verticalCenter
    text: "Option"
    font.pixelSize: radioButton.height - 4
  }

  MouseArea {
    anchors.fill: parent
    onClicked: parent.checked = !parent.checked
  }


}
