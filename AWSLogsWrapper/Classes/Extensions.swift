//
//  Extensions.swift
//  TaramsLogger
//
//  Created by RAJASEKHAR on 12/04/20.
//

import Foundation

extension DispatchQueue {
    
    private struct QueueReference { weak var queue: DispatchQueue? }
    
    private static let key: DispatchSpecificKey<QueueReference> = {
        let key = DispatchSpecificKey<QueueReference>()
        setupSystemQueuesDetection(key: key)
        return key
    }()
    
    private static func _registerDetection(of queues: [DispatchQueue], key: DispatchSpecificKey<QueueReference>) {
        queues.forEach { $0.setSpecific(key: key, value: QueueReference(queue: $0)) }
    }
    
    private static func setupSystemQueuesDetection(key: DispatchSpecificKey<QueueReference>) {
        let queues: [DispatchQueue] = [
            .main,
            .global(qos: .background),
            .global(qos: .default),
            .global(qos: .unspecified),
            .global(qos: .userInitiated),
            .global(qos: .userInteractive),
            .global(qos: .utility)
        ]
        _registerDetection(of: queues, key: key)
    }
}

// MARK: public functionality

public extension DispatchQueue {
    static func registerDetection(of queue: DispatchQueue) {
        _registerDetection(of: [queue], key: key)
    }
    
    static var currentQueueLabel: String? { current?.label }
    static var current: DispatchQueue? { getSpecific(key: key)?.queue }
}


public extension Bundle {
    
    var appName: String {
        guard let appName = infoDictionary?["CFBundleName"] as? String else {return ""}
        return appName
    }
    
    var bundleId: String {
        return bundleIdentifier ?? ""
    }
    
    var versionNumber: String {
        guard let versionNumber = infoDictionary?["CFBundleShortVersionString"] as? String else { return ""}
        return versionNumber
    }
    
    var buildNumber: String {
        guard let buildNumber = infoDictionary?["CFBundleVersion"] as? String else { return ""}
        return buildNumber
    }
}

public extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
    static var currentTimestamp: NSNumber { // current time in milli seconds
        return (Date().timeIntervalSince1970 * 1000.0) as NSNumber
    }
    
    var timestamp: NSNumber {
        return (self.timeIntervalSince1970 * 1000.0) as NSNumber
    }
}

extension UserDefaults {
    
    enum Key: String {
        case nextSequenceToken
    }
    static var nextSequenceToken: String {
        get {
            return UserDefaults.standard.string(forKey: Key.nextSequenceToken.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.nextSequenceToken.rawValue)
        }
    }
}
