//
//  LibreDemoCGMManager.swift
//  LibreTransmitter
//
//  Created by Pete Schwamb on 6/21/23.
//  Copyright © 2023 LoopKit Authors. All rights reserved.
//

import Foundation
import LibreTransmitter
import LibreTransmitterUI
import LoopKit
import LoopKitUI
import HealthKit
import os.log

class LibreDemoCGMManager: LibreTransmitterManagerV3 {
    var timer: Timer?

    private let log = OSLog(category: "LibreDemoCGMManager")


    public override var managerIdentifier: String {
        "LibreDemoCGMManager"
    }

    public override var pairingService: SensorPairingProtocol {
        return MockSensorPairingService()
    }

    public override var bluetoothSearcher: BluetoothSearcher {
        return MockBluetoothSearcher()
    }

    public required init() {
        super.init()

        self.lastConnected =  Date()

        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(5*60), repeats: true) { _ in
            self.reportMockSample()
        }

        // Also trigger a sample immediately, for dev convenience.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.reportMockSample()
        }
    }

    private func reportMockSample() {
        let date = Date()
        let value = 110.0 + sin(date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 3600 * 5) / (3600*5) * Double.pi * 2) * 60
        let quantity = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: value)
        let newSample = NewGlucoseSample(
            date: date,
            quantity: quantity,
            condition: nil,
            trend: nil,
            trendRate: nil,
            isDisplayOnly: false,
            wasUserEntered: false,
            syncIdentifier: "mock-libre + \(date)")
        log.debug("Reporting mock value of %{public}@", String(describing: value))
        self.delegateQueue.async {
            self.cgmManagerDelegate?.cgmManager(self, hasNew: CGMReadingResult.newData([newSample]))
        }
    }
}
