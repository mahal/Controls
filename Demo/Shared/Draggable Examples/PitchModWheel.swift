import SwiftUI
import DraggableControl

class PitchWheelModel: ObservableObject {
    @Published var location = 0.0
}

enum WheelType {
    case pitch
    case mod
}

struct PitchModWheel: View {

    var type: WheelType

    @StateObject var model = PitchWheelModel()

    var body: some View {
        GeometryReader { geo in
            Draggable(layout: type == .mod ? .relativeRectilinear() : .rectilinear,
                      value1: .constant(0),
                      value2: $model.location,
                      onEnded: { if type == .pitch { model.location = 0.5} })
            {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                        .frame(height: geo.size.height / 20)
                        .offset(y: -model.location * geo.size.height)
                }.animation(.spring(response: 0.2), value: model.location)
            }
        }.onAppear {
            if type == .pitch { model.location = 0.5 }
        }
    }
}


struct Fader_Previews: PreviewProvider {
    static var previews: some View {
        PitchModWheel(type: .pitch)
    }
}