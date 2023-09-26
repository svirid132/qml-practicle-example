import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ListView {
        id: listView
        x: 10; y: 10
        width: 100
        height: contentHeight > 100 ? 100 : contentHeight
        model: ['one', 'two', 'three']
        clip: true
        interactive: false
        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }
        delegate: Rectangle {
            implicitWidth: 100; implicitHeight: 50
            color: 'blue'
            Label {
                text: modelData
                color: 'white'
                anchors.centerIn: parent
            }
        }
    }
    Label {
        anchors.right: listView.right; anchors.left: listView.left
        anchors.top: listView.bottom
        text: "Ограниченый по размеру - max"
        wrapMode: Text.WordWrap
        height: 50
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
