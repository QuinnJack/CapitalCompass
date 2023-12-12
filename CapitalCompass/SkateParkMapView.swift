
import Foundation
import SwiftUI
import MapKit
import SnapPagerCarousel


struct SkateParkPlace: Hashable {
    
    var id: Self { self }
    
    var name: String
    var desc: String
    var icon: String
    var color: Color
    var latitude: CGFloat
    var longitude: CGFloat
    var pictureURL: String
    
}

struct SkateParkView: View {
    
    let defaultPlace = Place(name: "", desc: "", icon: "", color: .red, latitude: 0, longitude:0, pictureURL: "")
    
    // Kōtō city, Central Tokyo location
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    // Our items for Map and SnapCarousel
    @State var places: [Place] = []
    
    // Selected item for Map and SnapPager
    @State var selectedPlace: Place?
    
    // Index of selected place for SnapPager
    @State var indexPlace: Int = 0
    
    
    var body: some View {
        
        ZStack(alignment: .bottom)
        {
            // Map SwiftUI
            Map(position: $cameraPosition, selection: $selectedPlace) {
                
                ForEach(places, id: \.self) { place in
                    
                    Marker(place.name,
                           systemImage: place.icon,
                           coordinate: CLLocationCoordinate2D(latitude: place.latitude,
                                                              longitude: place.longitude))
                    .tint(place.color)
                    .tag(place)
                    
                }
                
            }.mapStyle(.standard(pointsOfInterest: .excludingAll))
            
            
            // Bottom Cards SlideShow
            SnapPager(items: $places,
                      selection: $selectedPlace,
                      currentIndex: $indexPlace,
                      edgesOverlap: 40,
                      itemsMargin: 10) { index, place in
             
                SkateParkCardView(place: place)
                
            }.frame(maxHeight: 100)
            
        }
        .navigationBarBackButtonHidden(true)

        .onChange(of: selectedPlace ?? defaultPlace) { oldValue, newValue in
            
            self.centerMapOnPlace(place: newValue)
            
        }
        .onAppear
        {
            self.loadPlaces()
        }
     
        
    }
    
    
    func loadPlaces()
    {
        // Need data
        
        places = [
                
            Place(name: "Lansdowne Park",
                  desc: "Flat asphalt surface",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.40037262273225,
                  longitude: -75.68119350047425,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Trillium Park",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.43644177724204,
                  longitude: -75.60115841374767,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Richcraft Recreation Complex - Kanata",
                  desc: "Large concrete bowl, 10 plus components, many street and vertical components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.341256245245944,
                  longitude: -75.9311228794333,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Diamond Jubilee Park",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.314086718089364,
                  longitude: -75.6095163095067,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Greely Village Park",
                  desc: "Flat concrete surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.265433080944035,
                  longitude: -75.55306585006588,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Berrigan Park",
                  desc: "Flat concrete surface, 10 plus components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.27569600450156,
                  longitude: -75.74734879410273,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Centennial Park",
                  desc: "Flat asphalt surface, 8 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.22266136351534,
                  longitude: -75.68674621451918,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Deevy Pines Park",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.290758029556564,
                  longitude: -75.85700981224976,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Eccolands Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.315355581350225,
                  longitude: -75.69539230060114,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Malvern Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.280622216608066,
                  longitude: -75.76023525531251,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Metcalfe Community Centre",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.2303256185616,
                  longitude: -75.46856164210584,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Walter Baker Park",
                  desc: "Concrete bowl, 7,000 sq ft",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.29501437996668,
                  longitude: -75.89861059991955,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Leslie Armstrong Park and Bearbrook Community Hall",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.38332153644999,
                  longitude: -75.33729877343951,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Doug Thompson Pathway",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.14411741679804,
                  longitude: -75.61144893063593,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Alexander Grove Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.26065977494502,
                  longitude: -75.92665136688457,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Andy Shields Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.26135398597832,
                  longitude: -75.55697850271004,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Fitzroy Harbour Community Centre and Campbell Bicentennial Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.470459865784335,
                  longitude: -76.20608770798111,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Constance Buckham's Bay Community Centre Park",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.499050061634904,
                  longitude: -76.0924495731868,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Vista Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.45039104418817,
                  longitude: -75.47100392241148,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "McNabb Park",
                  desc: "Flat concrete surface, 10 plus components (large half pipe), City run learn to skateboard programs, City run skateboard camps in summer",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.408488356977294,
                  longitude: -75.70362249994423,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Eugène Martineau Park - (FUTURE)",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.450696285065774,
                  longitude: -75.6320309678306,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Westboro Kiwanis Park",
                  desc: "Double half-pipe",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.38359281644615,
                  longitude: -75.7529312459768,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Rouncey Park",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.27540535796516,
                  longitude: -75.8809528511642,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Greenboro Skateboard Park",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.37540158721022,
                  longitude: -75.62599613156597,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Bob MacQuarrie Recreation Complex - Orléans",
                  desc: "Flat asphalt surface, 10 components, City run learn to skateboard programs, City run skateboard camps in summer",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.467134581776655,
                  longitude: -75.54651808655379,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Osgoode Community Centre",
                  desc: "Flat surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.14664909376471,
                  longitude: -75.60150415104602,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Blackburn Park",
                  desc: "Flat asphalt surface, 5 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.429643413290826,
                  longitude: -75.56279692044968,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Legacy Skate Park",
                  desc: "Large concrete bowl, many street and vertical components, 17,000 sq ft",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.34556666922493,
                  longitude: -75.76093333252653,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "CARDELREC Recreation Complex (Goulbourn)",
                  desc: "Flat asphalt surface, 6 components",
                  icon: "skateboard.fill",
                  color: .pink,
                  latitude: 45.262228609888595,
                  longitude: -75.90710869484667,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
                
        ]
        
        
        // Calculate the region that encompasses all the places
        centerMapOnAllPlaces()
        
    }
    
    
    func centerMapOnAllPlaces()
    {
        if let minLat = places.map({ $0.latitude }).min(),
           let maxLat = places.map({ $0.latitude }).max(),
           let minLon = places.map({ $0.longitude }).min(),
           let maxLon = places.map({ $0.longitude }).max()
        {
            let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
            
            // Add some padding in both latitude and longitude directions
                    
            let padding = 0.01 // Adjust the padding as needed
            let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat + padding * 2, longitudeDelta: maxLon - minLon + padding * 2)
                    
            
            let region = MKCoordinateRegion(center: center, span: span)
            
            cameraPosition = .region(region)
        }
        
    }
    
    
    func centerMapOnPlace(place: Place)
    {
        withAnimation {
            
            cameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), latitudinalMeters: 1000, longitudinalMeters: 1000))
            
        }
        
    }

    
}



struct SkateParkCardView: View {
    
    @State var place: Place
    
    var body: some View {
        
        ZStack {
            HStack {
                VStack(alignment:.leading, spacing: 8) {
                    Text(place.name)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text(place.desc)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                .padding(.leading, 8)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        
    }
    struct TransparentNavigationBar: ViewModifier {
        func body(content: Content) -> some View {
            content
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithTransparentBackground()
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().compactAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                }
        }
    }

}


#Preview {
    SkateParkView()
}
