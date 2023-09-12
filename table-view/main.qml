import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.qmlmodels 1.0
import TableModel 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    TableView {
        id: tableView
        anchors.fill: parent
        clip: true
        rowSpacing: 1
        columnSpacing: 1
        reuseItems: false // Стоит ли вностить данные в пул

        contentWidth: {
            let width = 0
            for (let i = 0; i < tableView.columns; ++i) {
                width += 100
                width += tableView.columnSpacing
            }

            return width
        }
        contentHeight: {
            let height = 0
            for (let i = 0; i < tableView.rows; ++i) {
                height += 50
                height += tableView.rowSpacing
            }

            return height
        }

        model: TableModel {}

        // если сложный delegate с несколькими delegate, то есть DelegateChooser
        delegate: Rectangle {
            implicitWidth: 100
            implicitHeight: 50
            Text {
                anchors.centerIn: parent
                text: display
            }

            TableView.onReused: {
                // Данные взяты из пула, а column, row и index обновлены
            }

            TableView.onPooled: {
                // Данные внесены в пул
            }
        }

        Canvas {
            id: canvas
            z: 2
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.strokeStyle = Qt.rgba(1, 0, 0, 1);
                ctx.lineWidth = tableView.rowSpacing
                let x = 0; let y = 0
                for (let a = 0; a < tableView.columns - 1; ++a) {
                    x += 100
                    x += tableView.columnSpacing / 2
                    ctx.moveTo(x, 0)
                    ctx.lineTo(x, tableView.contentHeight)
                    x += tableView.columnSpacing / 2
                }
                for (let i = 0; i < tableView.rows - 1; ++i) {
                    y += 50
                    y += tableView.rowSpacing / 2
                    ctx.moveTo(0, y)
                    ctx.lineTo(tableView.contentWidth, y)
                    y += tableView.rowSpacing / 2
                }
                ctx.stroke()
            }
        }
    }
}
