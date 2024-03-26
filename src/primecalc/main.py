from __future__ import annotations
import os

import sys
import signal

from qtpy.QtCore import QDir, QObject
from qtpy.QtGui import QGuiApplication
from qtpy.QtQml import QQmlApplicationEngine, QQmlComponent


def main() -> None:
    # Ensure that Ctrl-C works
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    app = QGuiApplication(sys.argv[1:])

    QDir.addSearchPath("qml", os.path.dirname(__file__))

    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.load("qml:main.qml")

    app.exec_()
