import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2

import MuseScore.UiComponents 1.0
import MuseScore.Ui 1.0

Column {
    id: root

    property QtObject propertyItem: null

    property alias titleText: titleLabel.text
    property bool isStyled: propertyItem ? propertyItem.isStyled : false
    property bool isModified: propertyItem ? propertyItem.isModified : false

    width: parent.width

    spacing: 8

    Item {
        height: contentRow.implicitHeight
        width: parent.width

        RowLayout {
            id: contentRow

            width: parent.width

            spacing: 4

            StyledTextLabel {
                id: titleLabel

                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true

                horizontalAlignment: Text.AlignLeft
            }

            FlatButton {
                id: menuButton

                icon: IconCode.MENU_THREE_DOTS
                normalStateColor: "transparent"

                onClicked: {
                    if (menu.opened) {
                        menu.close()
                        return
                    }

                    menu.open()
                }
            }

            ContextMenu {
                id: menu

                Layout.alignment: Qt.AlignRight
                Layout.fillWidth: true
                Layout.maximumWidth: 24
                Layout.preferredHeight: 24
                Layout.preferredWidth: 24

                y: menuButton.y + menuButton.height

                StyledMenuItem {
                    id: resetToDefaultItem

                    text: root.isStyled ? qsTr("Reset to style default") : qsTr("Reset to default")
                    checkable: false
                    enabled: root.isModified

                    onTriggered: {
                        if (propertyItem) {
                            propertyItem.resetToDefault()
                        }
                    }
                }

                StyledMenuItem {
                    id: applyToStyleItem

                    text: qsTr("Set as style")
                    checkable: true
                    checked: !root.isModified
                    enabled: root.isModified

                    onTriggered: {
                        if (propertyItem) {
                            propertyItem.applyToStyle()
                        }
                    }
                }

                function updateMenuModel() {
                    menu.clear()

                    menu.addItem(resetToDefaultItem)

                    if (root.isStyled) {
                        menu.addItem(applyToStyleItem)
                    }
                }
            }
        }
    }

    onPropertyItemChanged: {
        if (propertyItem) {
            menu.updateMenuModel()
        }
    }

    onIsStyledChanged: {
        if (propertyItem) {
            menu.updateMenuModel()
        }
    }
}
