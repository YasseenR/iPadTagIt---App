//
//  ContentView.swift
//  iPadTagIt
//
//  Created by Yasseen Rouni on 9/3/25.
//

import CodeScanner
import SwiftUI

struct ContentView: View {
    @State private var assetTag = ""
    @State private var isShowingScanner = false
    var body: some View {
        VStack {
            List {
                HStack {
                    TextField("Enter Asset Tag", text: $assetTag)
                        .frame(height: 50)
                }
            }
            Button(action: {
                isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "CPH10718", completion: handleScan)
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let details = result.string
            
            assetTag = details
        
            
        case .failure(let error):
            print("Scaning failed: \(error.localizedDescription)")
        }
        print("Handled Scan with asset tag: \(assetTag)")
    }
}

#Preview {
    ContentView()
}
