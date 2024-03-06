//
//  addnoteview.swift
//  Grades_v4
//
//  Created by Etienne Hüttl on 18.03.24.
//

import SwiftUI

struct addnoteview: View {
    @ObservedObject var storage: storageclass
    enum note: Double, CaseIterable, Identifiable {
        case one, two, three, five, six
        var id: Self { self }
    }

    
    
    @State var notenartinput: String = ""
    @State var dateinput: Date = Date()
    @State private var  selctednote: note = .one
    var body: some View {
        Group{
            VStack{
                Text("Art")
                    .bold()
                    .font(.system(size: 20))
                    .frame(width: (2*UIScreen.main.bounds.width) / 3, alignment: .leading)
                ZStack{
                    Rectangle()
                        .foregroundColor(Color("lightgray"))
                        .cornerRadius(10)
                    TextField("BSPW. Hü, KA, Epo", text: $notenartinput)
                        .padding(.horizontal)
                    
                    
                }.frame(height: UIScreen.main.bounds.height / 20)
                
                Divider()
                


                    DatePicker("Datum", selection: $dateinput)

                
                Divider()
                HStack{

                    Spacer()
                    Picker("Note", selection: $selctednote) {
                        Text("1").tag(note.one)
                        Text("2").tag(note.two)
                        Text("3").tag(note.three)
                        Text("5").tag(note.five)
                        Text("6").tag(note.six)

                    }
                    Spacer()
                }
                
                Divider()
                Button(action: {
                    
                    storage.addnote = false
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        Text("Speichern")
                            .bold()
                            .foregroundStyle(.white)
                    }.frame(height: UIScreen.main.bounds.height / 20)
                })
                Divider()
                Button(action: {
                    storage.addnote = false
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("lightgray"))
                            .cornerRadius(10)
                        Text("Zurück")
                            .bold()
                            .foregroundStyle(.blue)
                    }.frame(height: UIScreen.main.bounds.height / 20)
                })
            }
        }.padding()
            .background(.white)
            .cornerRadius(15)
    }
    
}

#Preview {
    Wrapper()
}
