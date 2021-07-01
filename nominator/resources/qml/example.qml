import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4 as QtControls
import QtWebEngine 1.1

import Common.Controls 1.0 as Common

/*
 * Removed comments
 */
Common.Dialog {
    id: root
    title: qsTr("<b>Web-services</b>")
    width: 1080
    height: 720
    sideMargins: details.margin
    hasActions: false

    Common.TabView {
        id: tabView
        _styleSource: "TransparentHeaderTabViewStyle.qml"
        frameVisible: true
        tabsVisible: true
        anchors {
            fill: parent
            margins: 5
        }

        Repeater {
            model: tabView.serviceModel
            QtControls.Tab {
                title: tabView.serviceModel[index].name

                WebEngineView {
                    anchors.fill: parent
                    url: tabView.serviceModel[index].url
                    // Removed comments
                    onCertificateError: error.ignoreCertificateError()
                }
            }
        }

        property var serviceModel: WebServicesController.tabsData()

        onServiceModelChanged: {
            var tipLabels = [];
            serviceModel.forEach(function(item) {
                tipLabels.push(item.details)
            });
            toolTipLabels = tipLabels;
        }

        property real tabsHeight: 37
        property var toolTipLabels
    }
    function openDialog() {
        PanelManager.openWindow(root, "dialogs");

        moveToCenter();
    }

    function moveToCenter() {
        root.x = window.width / 2 - root.width / 2;
        root.y = window.height / 2 - root.height / 2;
    }

    QtObject {
        id: details

        readonly property real margin: 10
    }
}
