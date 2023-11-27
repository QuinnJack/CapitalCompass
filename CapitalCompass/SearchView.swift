//
//  SearchView.swift
//  CapitalCompass
//
//  Created by Quinn Jackson on 2024-01-05.
//


import SwiftUI

struct SearchView: View {
    @Binding var searchText : String
    @Binding var icon: String
    @Binding var placeHolder: String
    
    
    var body: some View {
        
        HStack{
            HStack{
                Image(systemName: icon)
                    .foregroundColor(Color(.gray))
                
                TextField(placeHolder, text:$searchText)
                    .disableAutocorrection(true)
                    .foregroundColor(Color(.darkGray))
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 14)
                            .foregroundColor(Color(.darkGray))
                            .opacity(
                                searchText.isEmpty ?
                                0 : 0.6)
                            .onTapGesture {
                                searchText = ""
                            }
                        ,alignment: .trailing
                    )
                    .textFieldStyle(.plain)
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.white)
                    .shadow(
                        color: .black.opacity(0.29),
                        radius: 7,x: 0, y: 7
                    )
            )
        }
        .padding(.horizontal)
        .padding(.vertical)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""), icon: .constant("magnifyingglass"), placeHolder: .constant("Search Ottawa"))    }
}
