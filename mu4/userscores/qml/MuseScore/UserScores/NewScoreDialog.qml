import QtQuick 2.9
import QtQuick.Layouts 1.3

import MuseScore.Ui 1.0
import MuseScore.UiComponents 1.0
import MuseScore.UserScores 1.0

QmlDialog {
    id: root

    height: 500
    width: 900

    title: qsTrc("userscores", "New Score")

    Rectangle {

        NewScoreModel {
            id: newScoreModel
        }

        anchors.fill: parent
        color: ui.theme.backgroundPrimaryColor

        StackLayout {
            id: pagesStack
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.bottom: buttons.top
            anchors.bottomMargin: 39

            ChooseInstrumentsAndTemplatesPage {
                anchors.fill: parent
            }

            Rectangle {
                anchors.fill: parent

                color: "red"
            }
        }

        Row {
            id: buttons
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 16
            anchors.right: parent.right
            anchors.rightMargin: 16

            spacing: 12

            readonly property int buttonHeight: 30
            readonly property int buttonWidth: 132

            FlatButton {
                height: buttons.buttonHeight
                width: buttons.buttonWidth

                text: qsTrc("userscores", "Cancel")

                onClicked: {
                    root.ret = {errcode: 3}
                    root.hide()
                }
            }

            FlatButton {
                height: buttons.buttonHeight
                width: buttons.buttonWidth

                visible: pagesStack.currentIndex > 0

                text: qsTrc("userscores", "Back")

                onClicked: {
                    pagesStack.currentIndex--
                }
            }

            FlatButton {
                height: buttons.buttonHeight
                width: buttons.buttonWidth

                visible: pagesStack.currentIndex < pagesStack.count - 1

                text: qsTrc("userscores", "Next")

                onClicked: {
                    pagesStack.currentIndex++
                }
            }

            FlatButton {
                height: buttons.buttonHeight
                width: buttons.buttonWidth

                text: qsTrc("userscores", "Done")
            }
        }
    }
}
