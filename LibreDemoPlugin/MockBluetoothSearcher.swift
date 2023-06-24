//
//  MockBluetoothSearcher.swift
//  LibreDemoPlugin
//
//  Created by Pete Schwamb on 6/24/23.
//  Copyright © 2023 LoopKit Authors. All rights reserved.
//

import Foundation
import LibreTransmitter
import os.log
import Combine
import CoreBluetooth

struct MockBluetoothSearcher: BluetoothSearcher {
    fileprivate lazy var logger = Logger(forType: Self.self)

    public let throttledRSSI = GenericThrottler(identificator: \RSSIInfo.bledeviceID, interval: 5)
    public let passThroughMetaData = PassthroughSubject<(PeripheralProtocol, [String: Any]), Never>()

    func disconnectManually() {
        print("Mock searcher disconnecting")
    }

    func scanForCompatibleDevices() {
        print("Mock searcher scanning")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for device in mockData {
                passThroughMetaData.send((device, [:]))
            }
        }
    }

    func stopTimer() {
        print("Mock searcher stop timer")
    }

    var mockData: [PeripheralProtocol] {
        [
            MockedPeripheral(name: "device1"),
            MockedPeripheral(name: "device2"),
            MockedPeripheral(name: "device3"),
            MockedPeripheral(name: "device4")
        ]
    }

}

public class MockedPeripheral: PeripheralProtocol, Identifiable {
    public var name: String?

    public var name2: String {
        name ?? "unknown-device"
    }

    public var asStringIdentifier: String {
        name2
    }

    public init(name: String) {
        self.name = name
    }
}

