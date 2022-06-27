import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
  signal checked(bool checkValue)

  width: textItem.width + radioButton.width
  height: radioButton.height

  RadioButton {
    id: radioButton
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    checked: toggleArea.__checked
  }

  Text {
    id: textItem
    anchors.left: radioButton.right
    anchors.leftMargin: 4
    anchors.verticalCenter: radioButton.verticalCenter
    text: "Option"
    font.pixelSize: radioButton.height / 2 - 4
  }

  MouseArea {
    id: toggleArea
    anchors.fill: parent

    property bool __checked: false

    onClicked: {
      __checked = !__checked;
      parent.checked(__checked);
    }
  }

}
