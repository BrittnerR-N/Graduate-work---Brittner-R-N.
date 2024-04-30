//
//  ContentView.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 27.03.24.
//

import SwiftUI

struct AuthView: View {
    
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text(isAuth ? "Авторизация" : "Registration")
                .padding(isAuth ? 16 : 24)
                .padding(.horizontal, 40)
                .font(.title2.bold())
                .background(Color("whiteAlpha"))
                .cornerRadius(isAuth ? 30 : 60)
            
            VStack {
                TextField("Введите Email", text: $email)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                SecureField("Введите пароль", text: $password)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .foregroundColor(Color.black)
                        .padding()
                        .background(Color("whiteAlpha"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                }
                
                Button {
                    if isAuth {
                        print("Authorization")
                        AuthService.shared.signIn(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                                
                            case .success(_):
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Error authorization \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                        
                        
                    } else {
                        print("registr")
                        
                        guard password == confirmPassword else {
                            self.alertMessage = "Password not confirm"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        AuthService.shared.signUp(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                            case .success(let user):
                                alertMessage = "Are u already registr? \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                            case .failure(let error):
                                alertMessage = "Error with registr \(error.localizedDescription)!"
                                self.isShowAlert.toggle()
                            }
                        }
                    }
                } label: {
                    Text(isAuth ? "Войти" : "Create account")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("yellow"), Color("orange")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }
                
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Already have account!")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }
                
            }
            .padding()
            .padding(.top, 16)
            .background(Color("whiteAlpha"))
            .cornerRadius(24)
            .padding(isAuth ? 30 : 12)
            .alert(alertMessage,
                   isPresented: $isShowAlert) {
                Button { } label: {
                    Text("Ok")
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("bg")
                .ignoresSafeArea()
                .blur(radius: isAuth ? 0 : 6)
            )
            .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow) {
                
                if AuthService.shared.currentUser?.uid == "r4gz8Wf8RMQn8uv3FHVDutG9paI3" {
                    AdminOrdersView()
                } else {
                    
                    let maintabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                    MainTabBar(viewModel: maintabBarViewModel)
                }
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            AuthView()
        }
    }
}
