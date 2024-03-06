//
//  FachView.swift
//  Grades_v4
//
//  Created by Jakob Erlebach on 04.03.24.
//

import SwiftUI

struct FachView: View {
    
    var buttoncolor: Color = .red
    @ObservedObject var storage: storageclass
    var klassenarbeitenvorhanden: [testspeicher]
    var hüvorhanden: [testspeicher]
    var epovorhanden: [testspeicher]
    
    init(storage: storageclass) {
        self.storage = storage
        self.hüvorhanden = []
        self.klassenarbeitenvorhanden = []
        self.epovorhanden = []
        
        var counter = 0
        for jahr in storage.schuljahre{
            if jahr.jahr == storage.activeschuljahr{
                var counter2 = 0
                for fach in storage.schuljahre[counter].fächer{
                    if fach.name == storage.activefach{
                        var counter3 = 0
                        for test in storage.schuljahre[counter].fächer[counter2].tests{
                            switch test.testart {
                            case .hü:
                                self.hüvorhanden.append(storage.schuljahre[counter].fächer[counter2].tests[counter3])
                            case .klassenarbeit:
                                self.klassenarbeitenvorhanden.append(storage.schuljahre[counter].fächer[counter2].tests[counter3])
                            case .epo:
                                self.epovorhanden.append(storage.schuljahre[counter].fächer[counter2].tests[counter3])
                            }
                            counter3 += 1
                        }
                        
                    }
                    counter2 += 1
                }
            }
            counter += 1
        }
        
    }
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView{
                    
                    Divider()
                    
                    if klassenarbeitenvorhanden.count > 0{
                        HStack{
                            Text("Klassenarbeiten").frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .font(.title)
                                .bold()
                            
                        label: do {
                            HStack{
                                Text("-,--")
                                    .font(.title2)
                                    .foregroundStyle(Color("midgray"))
                                
                                Text("Ø").font(.title2)
                                    .bold()
                            }.padding(.trailing, 20)
                        }
                            
                        }
                        ForEach(klassenarbeitenvorhanden, id: \.self) { test in
                            Notenkasten(note: String(test.note), testtyp: test.testart)
                        }
                        
                        Divider()
                    }
                    
                    if hüvorhanden.count > 0{
                        HStack{
                            Text("HÜ´S").frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .font(.title)
                                .bold()
                            
                        label: do {
                            HStack{
                                Text("-,--")
                                    .font(.title2)
                                    .foregroundStyle(Color("midgray"))
                                
                                Text("Ø").font(.title2)
                                    .bold()
                            }.padding(.trailing, 20)
                        }
                            
                        }
                        ForEach(hüvorhanden, id: \.self) { test in
                            
                            Notenkasten(note: String(test.note), testtyp: test.testart)
                        }
                        
                        Divider()
                    }
                    if epovorhanden.count > 0{
                        HStack{
                            Text("EPO'S").frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .font(.title)
                                .bold()
                            
                        label: do {
                            HStack{
                                Text("-,--")
                                    .font(.title2)
                                    .foregroundStyle(Color("midgray"))
                                
                                Text("Ø").font(.title2)
                                    .bold()
                            }.padding(.trailing, 20)
                        }
                            
                        }
                        ForEach(epovorhanden, id: \.self) { test in
                            Notenkasten(note: String(test.note), testtyp: test.testart)
                        }
                        Divider()
                    }
                    
                    
                    Button("Löschen") {
                        
                    }.bold().font(.title3).foregroundColor(buttoncolor).frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    
                    
                }.navigationBarItems(trailing: Button(action: {
                    storage.addnote = true
                }){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                        .foregroundColor(.blue)
                } )
                .navigationBarItems(leading: Button(action: {
                    
                }){
                    Button(action: {
                        storage.activeview = .schuljahr
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                                .foregroundColor(.blue)
                            
                            Text("Zurück")
                        }
                    })
                    
                    
                } )
                .navigationTitle("Mathe")
            }
            if storage.addnote{
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea(edges: .all)
                
                addnoteview(storage: storage)
                    .padding(.horizontal, UIScreen.main.bounds.width / 6)
        }
        
    }
    
    }
}

struct FachView_Previews: PreviewProvider {
    static var previews: some View {
        Wrapper()
    }
}

