//
//  MockSensorPairingService.swift
//  LibreDemoPlugin
//
//  Created by Pete Schwamb on 6/22/23.
//  Copyright © 2023 LoopKit Authors. All rights reserved.
//

import Foundation
import LibreTransmitter
import Combine

class MockSensorPairingService: SensorPairingProtocol {

    private var readingsSubject = PassthroughSubject<SensorPairingInfo, Never>()

    public var publisher: AnyPublisher<SensorPairingInfo, Never> {
        readingsSubject.eraseToAnyPublisher()
    }

    func pairSensor() throws {
        print("Here")
    }
}
