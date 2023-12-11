
import Foundation
import SwiftUI
import MapKit
import SnapPagerCarousel


struct LandmarkPlace: Hashable {
    
    var id: Self { self }
    
    var name: String
    var desc: String
    var icon: String
    var color: Color
    var latitude: CGFloat
    var longitude: CGFloat
    var pictureURL: String
    
}

struct LandmarkView: View {

    let defaultPlace = Place(name: "", desc: "", icon: "", color: .red, latitude: 0, longitude:0, pictureURL: "")
    
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
             
                LandmarkCardView(place: place)
                
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
        
            places = [
                    
                Place(name: "Parliament Hill",
                      desc: "Iconic site of Canada's federal government, featuring grand architecture, historic sculptures, and expansive grounds.",
                      icon: "flag.fill",
                      color: .red,
                      latitude: 45.4251,
                      longitude: -75.6998,
                      pictureURL: "https://www.acec.ca/images/Advocacy/05Parlim/HillGood.jpg"),
                
                Place(name: "National Gallery of Canada",
                    desc: "Spectacular glass and granite museum featuring Canadian & indigenous art plus international works.",
                    icon: "theatermask.and.paintbrush.fill",
                    color: .purple,
                    latitude: 45.4295,
                    longitude: -75.6989,
                    pictureURL: "https://safdie-staging.imgix.net/0020fdc8-4900-4e3e-a0db-bcfd7372f539/01_B-F_NGC_E226_4x3.jpg?q=50&ixlib=imgixjs-3.6.1"),


                Place(name: "ByWard Market",
                    desc: "A buzzing hub of outdoor market stalls, specialty food shops, bars, restaurants & galleries.",
                      icon: "bag.fill",
                      color: .yellow,
                      latitude: 45.42771,
                      longitude: -75.692340,
                      pictureURL: "https://images.squarespace-cdn.com/content/v1/60bed59745a00c322d46a862/77346695-8b4b-40c3-be2f-ba8eddeaf0e1/BYWARD+STOCK-resized.jpg"),
                
            
                Place(name: "Rideau Canal",
                    desc: "Historic waterway filled with boats in the summer & turned into the world's largest skating rink in winter.",
                      icon: "water.waves",
                      color: .blue,
                      latitude: 45.426694,
                      longitude: -75.670513,
                      pictureURL: "https://media.gettyimages.com/id/1210700393/photo/a-general-view-of-the-venue-during-the-sports-climbing-tokyo-2020-olympic-test-event-at-the.jpg?s=612x612&w=gi&k=20&c=V6umi1b_JEDblDGEb06Smaqw5HQNBGlAz_8fjSl0ggk="),
                
            
                Place(name: "University of Ottawa",
                    desc: "A major bilingual public research university in the heart of Ottawa, known for its diverse programs, cutting-edge research, and vibrant campus life.",
                      icon: "graduationcap.fill",
                      color: .red,
                      latitude: 45.425161,
                      longitude: -75.684183,
                      pictureURL: "https://c8.alamy.com/comp/2BW110T/aqua-city-mall-with-odaiba-fuji-building-behind-on-a-sunny-day-tokyo-japan-2BW110T.jpg"),
                
            
                    Place(name: "Canadian War Museum",
                    desc: "A modern museum exploring Canada's international conflicts, especially those involving Canada, with artifacts, vehicles & more.",
                    icon: "figure.fencing",
                    color: .orange,
                    latitude: 45.4171,
                    longitude: -75.7169,
                    pictureURL: "https://media.gettyimages.com/id/1210700393/photo/a-general-view-of-the-venue-during-the-sports-climbing-tokyo-2020-olympic-test-event-at-the.jpg?s=612x612&w=gi&k=20&c=V6umi1b_JEDblDGEb06Smaqw5HQNBGlAz_8fjSl0ggk="),
            

                    
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



struct LandmarkCardView: View {
    
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
    LandmarkView()
}
