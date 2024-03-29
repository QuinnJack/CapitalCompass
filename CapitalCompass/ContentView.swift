    import SwiftUI
    import MapKit

    struct ContentView: View {
        @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
        let buttons = [("trophy.fill", "Landmarks"), ("tree.fill", "Gardens"), ("beach.umbrella.fill", "Beaches"), ("skateboard.fill", "Skate Parks")]
        @State private var selectedButton = "Home"
        @State private var searchText = ""
        @State private var results = [MKMapItem]()
        
        var body: some View {
            NavigationView {
                ZStack {
                    Map(position: $cameraPosition)
                        .mapControls {
                            MapCompass()
                            MapUserLocationButton()
                        }
                        .overlay(alignment: .top) {
                            SearchView(searchText: $searchText, icon: .constant("magnifyingglass"), placeHolder: .constant("Search Ottawa"))
                        }
                        .onSubmit(of: .text){
                            print("search \(searchText)")
                            Task {
                                await searchPlaces()
                            }
                        }
                    
                    VStack {
                                        Spacer()
                                        HStack(spacing: 0) {
                                            ForEach(buttons, id: \.1) { (icon, title) in
                                                NavigationLink(destination: viewForButton(title)) {
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
                                                        RadialGradient.gradientDoneSteps
                                                    )
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 14, height: 14)))
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
        func viewForButton(_ title: String) -> some View {
            switch title {
            case "Landmarks":
                return AnyView(LandmarkView())
            case "Gardens":
                return AnyView(GardenView())
            case "Beaches":
                return AnyView(BeachView())
            case "Skate Parks":
                return AnyView(SkateParkView())
            default:
                return AnyView(Text("Not Found"))
            }
        }

    }

    extension ContentView {
        func searchPlaces() async {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            request.region = .userRegion
            let searchResponse = try? await MKLocalSearch(request: request).start()
            self.results = searchResponse?.mapItems ?? []
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

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
