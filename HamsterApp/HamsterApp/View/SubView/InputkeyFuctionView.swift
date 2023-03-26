//
//  InputkeyFuctionView.swift
//  HamsterApp
//
//  Created by morse on 2023/3/20.
//

import SwiftUI

struct InputkeyFuctionView: View {
  @EnvironmentObject var appSettings: HamsterAppSettings

  var body: some View {
    ZStack {
      Color.HamsterBackgroundColor.opacity(0.1).ignoresSafeArea()

      VStack {
        HStack {
          Text("输入功能键设置")
            .font(.system(size: 30, weight: .black))
          Spacer()
        }
        .padding(.horizontal)
        
        VStack {
          HStack {
            Toggle(isOn: $appSettings.showSpaceLeftButton) {
              Text("空格左边按键")
                .font(.system(size: 16, weight: .bold, design: .rounded))
            }
          }
          if appSettings.showSpaceLeftButton {
            HStack {
              TextField("空格左边按键", text: $appSettings.spaceLeftButtonValue)
                .textFieldStyle(BorderTextFieldBackground(systemImageString: "pencil"))
                .padding(.vertical, 5)
                .foregroundColor(.secondary)
              Spacer()
            }
//            HStack {
//              Text("注意: 此键值依赖输入方案配置文件中的配置, 否则没有效果.")
//                .font(.footnote)
//                .foregroundColor(.secondary)
//              Spacer()
//            }
          }
        }
        .animation(.linear, value: appSettings.showSpaceLeftButton)
        .functionCell()

        
        VStack {
          HStack {
            Toggle(isOn: $appSettings.showSpaceRightButton) {
              Text("空格右边按键")
                .font(.system(size: 16, weight: .bold, design: .rounded))
            }
          }
          if appSettings.showSpaceRightButton {
            HStack {
              TextField("空格左边按键", text: $appSettings.spaceRightButtonValue)
                .textFieldStyle(BorderTextFieldBackground(systemImageString: "pencil"))
                .padding(.vertical, 5)
                .foregroundColor(.secondary)
              Spacer()
            }
            //            HStack {
            //              Text("注意: 此键值依赖输入方案配置文件中的配置, 否则没有效果.")
            //                .font(.footnote)
            //                .foregroundColor(.secondary)
            //              Spacer()
            //            }
          }
        }
        .animation(.linear, value: appSettings.showSpaceLeftButton)
        .functionCell()

        Spacer()
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct InputkeyFuctionView_Previews: PreviewProvider {
  static var previews: some View {
    InputkeyFuctionView()
      .environmentObject(HamsterAppSettings())
  }
}

struct FunctionCellModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding([.all], 15)
      .background(Color.HamsterCellColor)
      .foregroundColor(Color.HamsterFontColor)
      .cornerRadius(8)
      .hamsterShadow()
      .padding(.horizontal)
  }
}

extension View {
  func functionCell() -> some View {
    modifier(FunctionCellModifier())
  }
}
