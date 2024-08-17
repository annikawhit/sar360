//
//  TrainingArchiveView.swift
//  sar360
//
//  Created by Annika Whitwam on 2024-06-26.
//

import SwiftUI

struct TrainingArchiveView: View {
    @StateObject var viewModel = TrainingArchiveViewModel()
    
    /*private let userId: String
    
    init(userId: String){
        self.userId = userId
    }*/
    
    var fruits = ["apple", "banana", "orange", "kiwi"]
    @State private  var selectedFruit: String = "banana"
    
    let allItems = Array(1...50).map { "Item \($0)" } // Example data: 50 items
    @State private var currentIndex = 0
    private let itemsPerPage = 10

    var body: some View {
        NavigationView{
            VStack {
                
                HStack{
                    Text("Select Team:")
                    .font(.system(size: 20))
                    .foregroundColor(Color("CustomGreen"))
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.top, 10)
                    
                    Menu(content: {
                        Picker("fruits", selection: $selectedFruit) {
                            ForEach(fruits, id: \.self) { fruit in
                                Text(fruit)
                            }
                        }
                    }, label: {
                        (Text("\(selectedFruit) ") + Text(Image(systemName: "chevron.down")))
                    })
                    .padding(.all, 15)
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color("CustomGreen")))
                }
                
                ZStack{
                    VStack {
                        List(currentItems, id: \.self) { item in
                                NavigationLink(destination: RecordTrainingView()){
                                    Text(item)
                                }
                        }
                            
                        HStack {
                            Button(action: previousPage) {
                                Text("Previous")
                            }
                            .disabled(currentIndex == 0)
                                
                            Spacer()
                                
                            Button(action: nextPage) {
                                Text("Next")
                            }
                            .disabled(currentIndex + itemsPerPage >= allItems.count)
                        }
                        .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("CustomBackground"))
            .navigationTitle("Training Archive")
            .toolbar{
                Button {
                    viewModel.showingRecordTrainingViewModel = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingRecordTrainingViewModel){
                RecordTrainingView()
            }
        }
        
    }
    

    private var currentItems: [String] {
            let endIndex = min(currentIndex + itemsPerPage, allItems.count)
            return Array(allItems[currentIndex..<endIndex])
    }
        
    private func nextPage() {
            if currentIndex + itemsPerPage < allItems.count {
                currentIndex += itemsPerPage
            }
    }
        
    private func previousPage() {
            if currentIndex - itemsPerPage >= 0 {
                currentIndex -= itemsPerPage
            }
    }
}

struct TrainingArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingArchiveView()
    }
}