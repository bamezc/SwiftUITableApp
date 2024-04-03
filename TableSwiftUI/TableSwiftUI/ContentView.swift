//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Amezcua, Bella G on 4/3/24.
//



import SwiftUI
import MapKit

let data = [
    Item(name: "The Coffee Bar", neighborhood: "Downtown", desc: "The Coffee Bar has a great atmosphere and fun music to help you decompress during those tough study sessions!", lat: 29.88498433302821,  long: -97.93958320224789, imageName: "rest1"),
    Item(name: "Crater Coffee Co.", neighborhood: "Downtown", desc: "This coffee shop strives to create a perfect beverage for a quick pick-me-up during the day. Crater Coffee is a new shop located right next to campus! ", lat: 30.313960, long: -97.719760, imageName: "rest2"),
    Item(name: "The Sweet Spot", neighborhood: "Downtown", desc: "Craving a sweet treat? This cafe carries fun drinks and the yummiest snacks you can think of. The Sweet Spot makes the cutest mini pancakes with any topping of your choosing!", lat: 29.88624809906481,  long: -97.93958320224245, imageName: "rest3"),
    Item(name: "Tantra", neighborhood: "Downtown", desc: "Enjoy a nice cup of coffee or tea while listening to live music at Tantra's relaxing coffee shop!  ", lat: 29.88366958174343, long:  -97.9434596727785, imageName: "rest4"),
    Item(name: "Mochas & Javas", neighborhood: "Downtown", desc: "A comfortable place for the community to come together while enjoying extraordinary beverages, food, and legendary customer service. ", lat: 29.89292122469252, long:  -97.94121398524075, imageName: "rest5")
]
struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.885057426188062, longitude: -97.939411540873), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    
    
    var body: some View {
        NavigationView {
        VStack {
                   List(data, id: \.name) { item in
                       NavigationLink(destination: DetailView(item: item)) {
                       HStack {
                           Image(item.imageName)
                               .resizable()
                               .frame(width: 50, height: 50)
                               .cornerRadius(10)
                       VStack(alignment: .leading) {
                               Text(item.name)
                                   .font(.headline)
                               Text(item.neighborhood)
                                   .font(.subheadline)
                           }
                       } // end HStack
                       } // end NavigationLink
                   } // end List
            
Map(coordinateRegion: $region, annotationItems: data) { item in
MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
    Image(systemName: "mappin.circle.fill")
        .foregroundColor(.red)
         .font(.title)
         .overlay(
         Text(item.name)
             .font(.subheadline)
             .foregroundColor(.black)
             .fixedSize(horizontal: true, vertical: false)
             .offset(y: 25)
        )
        }
} // end map
.frame(height: 300)
.padding(.bottom, -30)
            
} // end VStack
    .listStyle(PlainListStyle())
    .navigationTitle("Austin Restaurants")
    } // end NavigationView
    } // end body
} // end ContentView

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    
        let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                Text("Neighborhood: \(item.neighborhood)")
                    .font(.subheadline)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
                // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

    Map(coordinateRegion: $region, annotationItems: [item]) { item in
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(.red)
                .font(.title)
                .overlay(
                    Text(item.name)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fixedSize(horizontal: true, vertical: false)
                        .offset(y: 25)
                        )
                 }
                 } // end Map
                     .frame(height: 300)
                     .padding(.bottom, -30)
                   
                    } // end VStack
                     .navigationTitle(item.name)
                     Spacer()
            
         } // end body
      } // end DetailView

#Preview {
    ContentView()
}
                    
    
