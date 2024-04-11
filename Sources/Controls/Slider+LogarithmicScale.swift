// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKitUI/

import SwiftUI

extension Binding where Value == Double {
    /// Returns a new version of the binding that scales the value logarithmically using the specified base. That is,
    /// when getting the value, `log_b(value)` is returned; when setting it, the new value is `pow(base, newValue)`.
    ///
    /// - Parameter base: The base to use.
    func logarithmic(base: Double = 10) -> Binding<Double> {
        Binding(
            get: {
                log10(self.wrappedValue) / log10(base)
            },
            set: { (newValue) in
                self.wrappedValue = pow(base, newValue)
            }
        )
    }
}

public extension Slider where Label == EmptyView, ValueLabel == EmptyView {
    /// Creates a new `Slider` with a base-10 logarithmic scale.
    ///
    /// As frequency is perceived logarithmically (two octaves are four times the frequency), 
    /// it's helpful to have logarithmically scaled inputs. Doesn't support Label and ValueLabel, 
    /// doesn't support `step:`
    /// 
    /// ## Example
    ///
    ///     @State private var frequency = 1.0
    ///
    ///     var body: some View {
    ///         Slider.withLog10Scale(value: $frequency, in: 20 ... 20000)
    ///     }
    ///
    /// - Parameters:
    ///   - value: A binding to the unscaled value.
    ///   - range: The unscaled range of values.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    static func withLog10Scale(
        value: Binding<Double>,
        in bounds: ClosedRange<Double>,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) -> Slider {
        return self.init(
            value: value.logarithmic(),
            in: log10(bounds.lowerBound) ... log10(bounds.upperBound),
            onEditingChanged: onEditingChanged
        )
    }
}
