//
//  DesignSpace.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-21.
//

import Foundation

public struct DesignSpace: Sendable {
    private var base: CGFloat
    
    public var space0: CGFloat { base * 0 }
    public var space1: CGFloat { base * 1 }
    public var space2: CGFloat { base * 2 }
    public var space4: CGFloat { base * 4 }
    public var space6: CGFloat { base * 6 }
    public var space8: CGFloat { base * 8 }
    public var space10: CGFloat { base * 10 }
    public var space12: CGFloat { base * 12 }
    public var space16: CGFloat { base * 16 }
    
    public init(base: CGFloat) {
        self.base = base
    }
}

public extension DesignSpace {
    static let `default`: DesignSpace = .init(base: 4)
}
