//
//  ProfileView.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 29.03.24.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAvaAlertPresented = false
    @State var isAuthViewPresented = false
    @State var isQuitAlertPresented = false
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                Image("user")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(12)
                    .background(Color("lightGray"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Foto?", isPresented: $isAvaAlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("From Gallerie")
                        }
                        
                        Button {
                            print("Camera")
                        } label: {
                            Text("From Camera")
                        }
                    }
                
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Name", text: $viewModel.profile.name)
                        .font(.body.bold())
                    HStack {
                     Text("+380")
                        TextField("50 84 83 885",value: $viewModel.profile.phone, format: IntegerFormatStyle.number)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки")
                    .bold()
                
                TextField("Germany, Hamburg, Billhorner Bruckenstrasse, 3", text: $viewModel.profile.address)
            }.padding(.horizontal)
            
            //Таблица с заказами
            List {
                if viewModel.orders.count == 0 {
                    Text("Ваши заказы")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
            }.listStyle(.plain)
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Go out")
                    .frame(width: 90)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding()
                .confirmationDialog("действительно хотите выйти?", isPresented: $isQuitAlertPresented) {
                    Button {
                        isAuthViewPresented.toggle()
                    } label: {
                        Text("Yes")
                }
            }
               
            
                .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                    AuthView()
                }
        }
        
        .onSubmit {
            viewModel.setProfile()
        }
        
        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: RNBUser(id: "",
                                                                 name: "Nikita12",
                                                                 phone: 12434567,
                                                                 address: "Where is it?")))
    }
}
