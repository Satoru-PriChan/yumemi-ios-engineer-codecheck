//
//  SearchConditionView.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/27.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchConditionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedSort: SearchSortType
    @Binding var selectedOrder: SearchOrderType
    @Binding var selectedPerPage: SearchPerPageType

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort By")) {
                    Picker("Sort By", selection: $selectedSort) {
                        ForEach(SearchSortType.allCases, id: \.self) { option in
                            Text(option.rawValue.capitalized).tag(option.rawValue)
                        }
                    }
                }

                Section(header: Text("Order")) {
                    Picker("Order", selection: $selectedOrder) {
                        ForEach(SearchOrderType.allCases, id: \.self) { option in
                            Text(option.rawValue.capitalized).tag(option.rawValue)
                        }
                    }
                }

                Section(header: Text("Per Page")) {
                    Picker("Per Page", selection: $selectedPerPage) {
                        ForEach(SearchPerPageType.allCases, id: \.self) { option in
                            Text("\(option.rawValue)").tag(option)
                        }
                    }
                }
            }
            .navigationTitle("Search Conditions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        // モーダルを閉じる
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SearchConditionView(
        selectedSort: .init(get: { .stars }, set: { _ in }),
        selectedOrder: .init(get: { .asc }, set: { _ in }),
        selectedPerPage: .init(get: { .thirty }, set: { _ in})
    )
}
