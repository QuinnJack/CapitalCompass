import SwiftUI
import MapKit

struct ContentView: View {
    @State private var cameraPosition: MKCoordinateRegion = .userRegion
    let buttons = [("house", "Home"), ("person", "Profile"), ("gear", "Settings"), ("questionmark.circle", "Help")]
    @State private var selectedButton = "Home"
    @State private var searchText = ""
    @State private var searchResults = [MKMapItem]()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $cameraPosition)
                .overlay(alignment: .top) {
                    SearchView(searchText: $searchText, icon: .constant("magnifyingglass"), placeHolder: .constant("Search Ottawa"))
                }
                .onSubmit(of: .text) {
                    Task {
                        await searchPlaces()
                    }
                }

            


            VStack {
                Spacer()

                HStack(spacing: 0) {
                    ForEach(buttons, id: \.1) { (icon, title) in
                        Button(action: {
                            self.selectedButton = title
                        }) {
                            VStack {
                                Image(systemName: icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .padding(.top)
                                    .padding(.horizontal)
                                Text(title)
                                    .font(.caption)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    .bold()
                            }
                            .foregroundStyle(.white)
                            .background(
                                RadialGradient(gradient: Gradient(colors: [.blue, .purple]), center: .center, startRadius: 20, endRadius: 100)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .primary.opacity(0.7), radius: 2, x: 0, y: 2)
                            .scaleEffect(0.8)
                            .offset(y: 14)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .background(Color.clear)
            }
        }
    }
}

extension ContentView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = cameraPosition
        let response = try? await MKLocalSearch(request: request).start()
        searchResults = response?.mapItems ?? []

    }
}
            
extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        .init(latitude: 45.415, longitude: -75.6972)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        .init(center: .userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}


