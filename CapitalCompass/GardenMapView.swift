
import Foundation
import SwiftUI
import MapKit
import SnapPagerCarousel


struct GardenPlace: Hashable {
    
    var id: Self { self }
    
    var name: String
    var desc: String
    var icon: String
    var color: Color
    var latitude: CGFloat
    var longitude: CGFloat
    var pictureURL: String
    
}

struct GardenView: View {
    
    let defaultPlace = Place(name: "", desc: "", icon: "", color: .red, latitude: 45.415, longitude:-75.6972, pictureURL: "")
    
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
             
                GardenCardView(place: place)
                
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
            
            Place(name: "Orleans Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.48375652897202,
                  longitude: -75.4989466311528,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Gloucester Allotment Gardens Association (Location 1)",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.42082612716965,
                  longitude: -75.56740258954132,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Michele Heights Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.355234593260235,
                  longitude: -75.80057654298305,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Bethany Church Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.345486053732806,
                  longitude: -75.7733698568523,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Nepean Allotment Gardens Association",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.34651054816256,
                  longitude: -75.7180421437794,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Friendship Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.42735617882686,
                  longitude: -75.63619367288655,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Lowertown/Basseville Community Garden (Location 1)",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.43476683787977,
                  longitude: -75.68176548638256,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Strathcona Heights Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.4187323045975,
                  longitude: -75.66942405173018,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Chateau Donald Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.429309772591154,
                  longitude: -75.65770310988646,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Nanny Goat Hill Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41530432484318,
                  longitude: -75.70748510801351,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Sweet Willow Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41179436046534,
                  longitude: -75.71334116503489,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Debra Dynes Family House Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.368122626262746,
                  longitude: -75.70674070978212,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Ottawa Children's Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.406091125466276,
                  longitude: -75.6759959798996,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Ottawa East Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.407950995906916,
                  longitude: -75.67537849646644,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Bytown Urban Gardens (BUGs) CG",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.40503420130164,
                  longitude: -75.69917180424774,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Jardin Arrowsmith Thyme-Less Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.4385512204825,
                  longitude: -75.59537591453606,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Kilborn Allotment Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.39126266926882,
                  longitude: -75.63877645820132,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Vars Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.35201847126405,
                  longitude: -75.35266817139761,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Lees Ave Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41426930416648,
                  longitude: -75.6716562331182,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Brewer Park Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.38863566601492,
                  longitude: -75.69128844412404,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Bayshore Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.35064666539259,
                  longitude: -75.80999930738432,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Pinecrest Terrace Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.35278422038218,
                  longitude: -75.775526039381,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Russell Heights Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.404141538059086,
                  longitude: -75.6290510144031,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Neighbourhood Tomato Community Garden-West Carleton",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.34640835178103,
                  longitude: -76.03726429898296,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Oasis Food Growing Project",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.42934565107159,
                  longitude: -75.68310044806015,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Partage Vanier Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.43988390294372,
                  longitude: -75.66509606037806,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Overbrook Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.42578186681062,
                  longitude: -75.65532627724934,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Leslie Park Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.334275274444884,
                  longitude: -75.78753726289284,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "28th Nepean Girl Guide Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.33808428632724,
                  longitude: -75.77707013918273,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Fatima Manor for Seniors",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.43852565940125,
                  longitude: -75.66119548209763,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Vanier Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.443757565601814,
                  longitude: -75.65854907858426,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Urban Shades Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.42741968184064,
                  longitude: -75.67712834951857,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "New Edinburgh Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.44063511309772,
                  longitude: -75.6831064371666,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Brooke Tower Communal Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41514934186597,
                  longitude: -75.6855648355586,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Centretown Community Gardening Project",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.4151913460626,
                  longitude: -75.70167355561371,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Growing Up Organic",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.38942514017135,
                  longitude: -75.73106059719437,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "CHEO Healing Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.40144707574397,
                  longitude: -75.65007843747948,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Russell Manor Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.401795399180585,
                  longitude: -75.62588271151147,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Trinity Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.40552654268694,
                  longitude: -75.64906324036696,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Cardinal Creek Children's Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.478825817478075,
                  longitude: -75.4575760621967,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Centretown United Centre 507 Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.410473945391374,
                  longitude: -75.69211863920249,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Gloucester Allotment Gardens Association (Location 2)",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.429950579962885,
                  longitude: -75.55952654714092,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Kanata North Community Gardens",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.34841816240767,
                  longitude: -75.94444429082098,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Lowertown/Basseville Community Garden (AKA: Angel Square Garden / Location 2)",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.434657385260486,
                  longitude: -75.68070685814213,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "McNabb Park Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.40876359398198,
                  longitude: -75.70386826443739,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Osgoode Township Museum Heritage School Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.16010637189682,
                  longitude: -75.46209607416529,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Sandy Hill CG",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41963700188407,
                  longitude: -75.66802600635503,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "St. Joe's Supper Table",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.425107469403876,
                  longitude: -75.68425623062069,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "St.Laurent Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.390825255088664,
                  longitude: -75.61902746635704,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "West Barrhaven Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.27104358060477,
                  longitude: -75.7576925285328,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Greenstar Enterprises",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.386531093002866,
                  longitude: -75.63519587535446,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "800 St.Laurent Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.43470126290657,
                  longitude: -75.64436991621612,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Lexington Green Life Gardens",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.39201412464802,
                  longitude: -75.67793282117366,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Lindenlea Food & Wildlife Gardens",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.444511838303406,
                  longitude: -75.67493597273635,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Maple Hill Urban Farm Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.333741904797385,
                  longitude: -75.84149060584191,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Queensway Terrace North Community Gardens",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.35663936758133,
                  longitude: -75.78858257891359,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Revell Court Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.36556541375141,
                  longitude: -75.63075769234882,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Russell Gardens Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.3978742878257,
                  longitude: -75.61850302832349,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "South Nepean Muslim Centre Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.28887720673759,
                  longitude: -75.72708381793238,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "The Peaceful Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.35062885677737,
                  longitude: -75.67752578112511,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Hope Living Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.29141322615575,
                  longitude: -75.88045400855394,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Brittania Woods Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.35883128148959,
                  longitude: -75.8002956047522,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Care & Share Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.31615545761121,
                  longitude: -75.9007118435783,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Chapel Ridge Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.25475476964805,
                  longitude: -75.8719035435388,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Clementine Towers Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.37236824268114,
                  longitude: -75.64924107110411,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Free Food Project",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.254975128396225,
                  longitude: -75.91415259951648,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Heron Gate Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.378673729825316,
                  longitude: -75.65051826983972,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Kanata South Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.29596902012188,
                  longitude: -75.8870388932079,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Kitigànensag",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.417553617692846,
                  longitude: -75.7092846202534,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Knox Church Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.326034465471224,
                  longitude: -75.77416792976656,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Lotus Peace Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.44574047359726,
                  longitude: -75.61073659546457,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Off Bank",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41735628900105,
                  longitude: -75.69733315575291,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Ottawa Salus Gladstone Rosemount Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.404054332509546,
                  longitude: -75.71305638468489,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Patsy's Planting Patch",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.36819223879563,
                  longitude: -75.77288221854064,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Richmond Fair Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.195107307796604,
                  longitude: -75.83813444874683,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "St.Lukes Supper Table",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.41012288044173,
                  longitude: -75.708390833926,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Tanglewood Park Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.33661083231415,
                  longitude: -75.73038022410098,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "The Hope Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.37236824268114,
                  longitude: -75.64924107110411,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "University of Ottawa Sustainability Office",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.42048855749457,
                  longitude: -75.68022543890712,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Westboro Food Bank",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.392118210058584,
                  longitude: -75.75480937969272,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Carlington Community Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.3764491096353,
                  longitude: -75.74263032375706,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Beausoleil Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.432987446892106,
                  longitude: -75.68371853157177,
                  pictureURL: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852"),
            Place(name: "Ottawa Salus Gladstone Rosemount Garden",
                  desc: "",
                  icon: "leaf.fill",
                  color: .green,
                  latitude: 45.40146198145381,
                  longitude: -75.72551956339954,
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



struct GardenCardView: View {
    
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
    GardenView()
}
