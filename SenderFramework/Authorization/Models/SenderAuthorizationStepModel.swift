//
// Created by Roman Serga on 8/6/17.
// Copyright (c) 2017 Middleware Inc. All rights reserved.
//

import Foundation

@objc(MWSenderAuthorizationStep)
public enum SenderAuthorizationStep: NSInteger {
    case none
    case initialization
    case phone
    case OTP
    case IVR
    case confirm
    case name
    case photo
    case userInfo
    case success
    case failure
}

@objc(MWSenderAuthorizationStepModel)
public class SenderAuthorizationStepModel: NSObject {
    public var step: SenderAuthorizationStep
    public var error: Error?
    public var additionalData: [String: Any]?

    init(step: SenderAuthorizationStep) {
        self.step = step
        super.init()
    }
}