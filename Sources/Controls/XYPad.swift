import SwiftUI

public struct XYPad: View {
    @Binding var x: Double
    @Binding var y: Double

    public init(x: Binding<Double>, y: Binding<Double>) {
        _x = x
        _y = y
    }

    public var body: some View {
        Draggable(geometry: .rectilinear, value: $x, value2: $y) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: geo.size.width / 20).foregroundColor(.gray)
                Circle().foregroundColor(.red)
                    .frame(width: geo.size.width / 10, height: geo.size.height / 10)
                    .offset(x: x * (geo.size.width - geo.size.width / 10),
                            y: -y * (geo.size.height - geo.size.height / 10))
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        XYPad(x: .constant(0.33), y: .constant(0.33))
    }
}