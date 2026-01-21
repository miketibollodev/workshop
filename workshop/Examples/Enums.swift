//
//  Enums.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-21.
//

///
/// Enumerations are a data type that has some fixed set of related
/// values. These are value types, usually used for namespaces.
///
enum Barcode {
    
    /// Associated values allow enums to store values of other types along
    /// with the case value. For example, a UPC style of barcode might be
    /// created with:
    /// ```
    /// var barcode = Barcode.upc(8, 85094, 51424, 3)
    /// ```
    case upc(Int, Int, Int, Int)
    case qrCode(String)
    
    var code: String {
        switch self {
            /// We can apply `let` or `var` before the case name if all
            /// associated values will be constants or variables.
        case let .upc(num, manufacturer, product, check):
            return "UPC:\(num)\(manufacturer)\(product)\(check)"
            /// Otherwise, we can apply `let` or `var` to each type
            /// independent of another
        case .qrCode(let product):
            return "QR:\(product)"
        }
    }
}


///
/// Enums can instead use raw values, where each case is assigned a
/// default value, of which all must be the same type. The type must be
/// specified as the defined type in the declaration.
///
/// Raw values can be `String`, `Character`, `Int`, or `Float`.
///
enum Weather: Int {
    case rain = 0
    case snow = 1
    case sunny = 2
}
