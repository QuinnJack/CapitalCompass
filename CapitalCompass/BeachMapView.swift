
import Foundation
import SwiftUI
import MapKit
import SnapPagerCarousel


struct BeachPlace: Hashable {
    
    var id: Self { self }
    
    var name: String
    var desc: String
    var icon: String
    var color: Color
    var latitude: CGFloat
    var longitude: CGFloat
    var pictureURL: String
    
}

struct BeachView: View {
    
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
             
                BeachCardView(place: place)
                
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
                
            Place(name: "Petrie Island River Beaches",
                  desc: "Ottawa’s newest beach offers a wonderful expanse of views and sand across the Ottawa River. Key amenities include washrooms; pay parking (7 am to 6 pm); an interpretation cottage; and 12 picnic tables",
                  icon: "water.waves",
                  color: .blue,
                  latitude: 45.50677311004009,
                  longitude: -75.49022471820163,
                  pictureURL: "https://img1.wsimg.com/isteam/ip/3f0adf0b-a810-464f-a8a3-84f82bf505ac/20210517_170345.jpg/:/cr=t:0%25,l:0%25,w:100%25,h:100%25/rs=w:1280"),
            
            
            Place(name: "Westboro Beach",
                  desc: "A key hub on the Ottawa side of the historic Ottawa River covered by the Ottawa River South Shore Riverfront Park Plan",
                  icon: "beach.umbrella.fill",
                  color: .cyan,
                  latitude: 45.39539726009651,
                  longitude: -75.76127098678396,
                  pictureURL: "https://s3.amazonaws.com/cdn.swimdrinkfishguide.com/photos/97431b3321d3e2b85a6b60c1f298a327b8244507.jpg?assetVersion=1690304438088"),
            
        
            Place(name: "Britannia Beach",
                  desc: "Large, spacious beach, picnic pavilions, and a children's playground with one of the city's bike trails also running through the park",
                  icon: "figure.pool.swim",
                  color: .purple,
                  latitude: 45.36507331981652,
                  longitude: -75.80151267553116,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/7/77/BritanniaBeach.jpg"),
            
        
            Place(name: "Mooney's Bay Beach",
                  desc: "This public park has a beach, picnic areas, a children's playground, the Sue Holloway Fitness Park, and is the site of the Terry Fox Stadium.",
                  icon: "sailboat.fill",
                  color: .blue,
                  latitude: 45.36684363443651,
                  longitude: -75.69267844341542,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/a/ae/Mooneys-bay-beach.jpg"),
            
        
           
                
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



struct BeachCardView: View {
    
    @State var place: Place
    
    var body: some View {
        
        ZStack
        {
            HStack{
                
                AsyncImage(url: URL(string: place.pictureURL)! ){ image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .scaledToFill()
                .frame(width: 65, height: 65)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment:.leading, spacing: 8)
                {
                    Text(place.name)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
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
    BeachView()
}
