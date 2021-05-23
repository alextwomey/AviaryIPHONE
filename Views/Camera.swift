//
//  Camera.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import SwiftUI

struct Camera: View{
    @State private var showNewBird = false
    
   
    var body: some View{
        ZStack{
            VStack{
                Image("aviaryLogo2")
                    .resizable()
                    //.aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width:200)
                Button(action: {
                    self.showNewBird = true
                    
                }) {
                    Text("Add a new bird")
                        .font(.system(.headline, design: .rounded))
                        .frame(width: 200)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(15)
                }
                .padding(.bottom)
                
            }//vstack
            if showNewBird {
                BlankView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showNewBird = false
                    }
                
                AddingBirdView(isShow: $showNewBird)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            }//if
        }//zstack
        
    }//body
    
    
    
}//struct
struct AddingBirdView: View{
    @Environment(\.managedObjectContext) var context
    @Binding var isShow: Bool
    @State var isEditing = false
    @State var birdName: String = ""
    @State var sciName: String = ""
    @State var howMany: String = ""
    @ObservedObject var lm = LocationManager()
    
    private func addBird(birdName:String,sciName:String,howMany:String){
        let lat = lm.location?.latitude
        let long = lm.location?.longitude
        let bird = Bird(context: context)
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        bird.id = UUID()
        bird.birdName = birdName
        bird.sciName = sciName
        bird.howMany = howMany
        bird.lat = lat!
        bird.long = long!
        bird.obsDate = formatter.string(from: Date())
        
        
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }//addBird
    
    var body: some View{
        VStack{
            Spacer()
            VStack(alignment: .leading){
                HStack {
                    Text("Enter new bird")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                        
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }//hstack
                TextField("Enter the birds common name", text: $birdName, onEditingChanged: { (editingChanged) in
                    
                    self.isEditing = editingChanged
                    
                })
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom)
                TextField("Enter the birds scientific name (optional)", text: $sciName, onEditingChanged: { (editingChanged) in
                    
                    self.isEditing = editingChanged
                    
                })
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom)
                TextField("How many did you see?", text: $howMany, onEditingChanged: { (editingChanged) in
                    
                    self.isEditing = editingChanged
                    
                }).keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom)
                Button(action: {
                    self.isShow = false
                    self.addBird(birdName: birdName, sciName: sciName, howMany: howMany)
                    
                }) {
                    Text("Save")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(15)
                }
                .padding(.bottom)
            }//vstack
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            //.offset(y: isEditing ? -320 : 0)
            
            
        }//vstack
        //.edgesIgnoringSafeArea(.bottom)
    }//body
    
}//sddingBirdView
struct BlankView : View {

    var bgColor: Color

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }//body
}//blankView

struct Camera_Previews: PreviewProvider {
    static var previews: some View {
        Camera()
    }//previews
}//contentPreview
