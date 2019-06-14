//
//  SimpleView.swift
//  LearnSwiftUI
//
//  Created by apple on 2019/6/10.
//  Copyright © 2019 wintelsui. All rights reserved.
//

import SwiftUI

struct SimpleView : View {
    
    //状态属性参数
    @State private var alertHello = false
    @State private var toggleHello = false
    @State private var sliderHello = 10.0
    @State private var stepperHello : Int = 1
    @State private var textFieldHello: String = ""
    @State private var secureFieldHello: String = ""
    @State private var datePickerHello = Date()
    @State private var pickerHelloIndex: Int = 1
    
    private let pickerHelloList = ["P1", "P2", "P3"]
    
    var body: some View {
        /**
         在SwiftUI Essentials视频是看到有Form这个东西,但是貌似现在还没有实现,
         TextField没找到方法设置KeyBoard的Type,同样也没有找到becomeFirstResponder和resignFirstResponder类似的方法
         
         VStack只有 HorizontalAlignment?
         **/
        ScrollView(isScrollEnabled: true, alwaysBounceHorizontal: false, alwaysBounceVertical: true, showsHorizontalIndicator: false, showsVerticalIndicator: false) {
            
            
            VStack(alignment: .center, spacing: 10.0) {
                HStack {
                    Image(systemName: "person.fill")
                    Image("aragaki")
                        .resizable()
                        .frame(width: Length(64.0), height: Length(64.0))
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .clipShape(Circle())
                    
                    Text("Hello Text!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .color(.black)
                        .multilineTextAlignment(.center)
                        .background(Color.yellow)
                    //                    .padding(.horizontal, 25.2)
                }
                //按钮
                Button(action: helloButtonPressed) {
                    Text("Hello Button!")
                    
                    }.presentation($alertHello) { () -> Alert in
                        Alert(title: Text("Hello Alert:Toggle will \(toggleHello == true ? "turn on" : "turn off")"))
                }
                Spacer().frame(height: 5.0)
                //Switch
                Toggle(isOn: $toggleHello) {
                    Text("Hello Toggle!")
                }
                
                HStack {
                    Text("TextField：").color(.gray)
                    
                    TextField($textFieldHello,
                              placeholder: Text("Hello TextField!"),
                              onEditingChanged: { changed in
                                print(" onEditingChanged:\(self.textFieldHello)")
                    },
                              onCommit: helloTextFieldonCommit)
                }
                //            HStack {
                //                Text("Password：").color(.gray)
                //
                //                SecureField($secureFieldHello, placeholder: Text("Hello SecureField!")) {
                //
                //                    print("SecureField: \(self.secureFieldHello)")
                //
                //                    UIApplication.shared.keyWindow?.endEditing(true)
                //                }
                //            }
                
                //Stepper
                Stepper(value: $stepperHello, in: 1...10, step: 1) {
                    Text("Stepper:\(self.stepperHello)")
                }
                HStack{
                    Text("Hello Slider:\(String(format:"%.2f",self.sliderHello))")
                    Slider(value: $sliderHello, from: 0.0, through: 100.0)
                }
                DatePicker($datePickerHello, minimumDate: Date(timeIntervalSince1970: 0)
                    , maximumDate: Date(timeIntervalSinceNow: TimeInterval(25 * 365 * 24 * 60 * 60)), displayedComponents: [.date])
                
                Text("Hello DatePicker:\(getDatePickerDateString())")
            }
        }
            .navigationBarTitle(Text("Simple UIs"), displayMode: .inline)
    }
    
    func helloTextFieldonCommit() {
        print("helloTextFieldonCommit:\(self.textFieldHello)")
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    func helloButtonPressed() {
        alertHello = true
        if self.toggleHello {
            //Toggle无动画
            self.toggleHello = !self.toggleHello
        }else{
            //Toggle有动画
            withAnimation{
                self.toggleHello.toggle()
            }
        }
    }
    
    func getDatePickerDateString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone.current
        dateformatter.dateFormat = "YYYY/MM/dd"
        let dateString = dateformatter.string(from: datePickerHello)
        return dateString
    }
}

#if DEBUG
struct SimpleView_Previews : PreviewProvider {
    static var previews: some View {
        SimpleView()
    }
}
#endif

