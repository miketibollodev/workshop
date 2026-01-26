//
//  Icons.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

///
/// When adding a resource, use a PDF file and place it in the correct folder by Style/Purpose in
/// `Assets.xcassets`. Ensure that in the property inspector, select `Template Image` in
/// `Render As` and select `Preserve Vector Data` in `Resizing`. Then, add the resource
/// in the correct enum by Style/Purpose.
///
public enum Icons {
    public enum Filled {
        public enum Action {
            public static let creditCard: ImageResource = .creditCard
            public static let done: ImageResource = .done
            public static let help: ImageResource = .help
            public static let home: ImageResource = .home
            public static let search: ImageResource = .search
            public static let translate: ImageResource = .translate
            public static let visibility: ImageResource = .visibility
            public static let visibilityOff: ImageResource = .visibilityOff
        }
        public enum Navigation {
            public static let arrowLeft: ImageResource = .arrowLeft
            public static let arrowRight: ImageResource = .arrowRight
            public static let chevronDown: ImageResource = .chevronDown
            public static let chevronLeft: ImageResource = .chevronLeft
            public static let chevronRight: ImageResource = .chevronRight
            public static let close: ImageResource = .close
            public static let ellipsisHorizontal: ImageResource = .ellipsisHorizontal
            public static let ellipsisVertical: ImageResource = .ellipsisVertical
            public static let fullscreen: ImageResource = .fullscreen
            public static let fullscreenExit: ImageResource = .fullscreenExit
            public static let refresh: ImageResource = .refresh
            public static let unfoldLess: ImageResource = .unfoldLess
            public static let unfoldMore: ImageResource = .unfoldMore
        }
        public enum Social {
            public static let building: ImageResource = .building
            public static let deck: ImageResource = .deck
            public static let earth: ImageResource = .earth
            public static let lightbulb: ImageResource = .lightbulb
            public static let people: ImageResource = .people
            public static let personAdd: ImageResource = .personAdd
            public static let yoga: ImageResource = .yoga
        }
    }
}
