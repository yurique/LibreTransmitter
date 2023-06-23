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

class LibreDemoCGMManager: LibreTransmitterManagerV3 {
    public override var managerIdentifier: String {
        "LibreDemoCGMManager"
    }


    public override var service: SensorPairingProtocol {
        return MockSensorPairingService()
    }
    
}
