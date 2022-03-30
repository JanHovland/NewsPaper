//
//  ConnectToInternet.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import SwiftUI
import Network

func ConnectToInternet() -> (Bool, LocalizedStringKey) {
    
    var hasConnectionPath = false
    
    let internetMonitor = NWPathMonitor()
    let internetQueue = DispatchQueue(label: "InternetMonitor")
    
    var device: LocalizedStringKey = ""
    
    
    /// Only fires once
    guard internetMonitor.pathUpdateHandler == nil else {
        return (hasConnectionPath, device)
    }
    internetMonitor.pathUpdateHandler = { update in
        if update.status == .satisfied {
            hasConnectionPath = true
        } else {
            hasConnectionPath = false
        }
    }
    internetMonitor.start(queue: internetQueue)

    /// Legger inn en forsinkelse på 1 sekund
    /// Uten denne, kan det komme melding selv om Internett er tilhjengelig
    sleep(1)
#if os(iOS)
    if  hasConnectionPath == false {
        if UIDevice.current.localizedModel == "iPhone" {
            device = "iPhone"
        } else if UIDevice.current.localizedModel == "iPad" {
            device = "iPad"
        }
    }
#endif
    return (hasConnectionPath, device)
}
