//
//  AuthRegistrationBlock.swift
//  ICE
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct AuthRegistrationBlockView: View {
    let title: String
    let description: String
    let time: Int
    let comlpetionStatus: CompletionStatus
    let handler: () -> Void
    
    var body: some View {
        HStack {
            self.statusCircle
            if self.comlpetionStatus == .completing { self.openedContent } else { self.closedContent }
        }
    }
    
    private var statusCircle: some View {
        Group {
            switch self.comlpetionStatus {
            case .completed:
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 24))
                    .foregroundColor(Color.theme.accent)
            case .completing:
                Circle().foregroundColor(Color.theme.accent)
            case .toBeCompleted:
                Circle().strokeBorder(Color.theme.accent, lineWidth: self.CIRLE_LINE_WIDTH)
            }
                
        }
        .frame(width: self.CIRCLE_SIZE, height: self.CIRCLE_SIZE)
        .padding(.trailing, self.CIRCLE_TRAILING_PADDING)
    }
    
    private var openedContent: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.title)
                self.timeBadge(text: "\(self.time) min")
            }
            Text(self.description).subtitleTextStyle(reduced: true)
                .padding(.top, 1)
            PrimaryButtonView(title: "Continue", handler: self.handler)
                .padding(.top)
        }
        .padding()
        .background(Color.theme.card)
        .cornerRadius(self.BLOCK_CORNER_RADIUS)
    }
    
    private var closedContent: some View {
        HStack {
            Text(self.title)
            if self.comlpetionStatus == .completed {
                self.timeBadge(text: "Make changes")
            } else {
                self.timeBadge(text: "\(self.time) min")
            }
        }
    }
    
    private func timeBadge(text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(Color.theme.accent)
            .padding(.horizontal, self.BADGE_HORIZONTAL_PADDING)
            .padding(.vertical, self.BADGE_VERTICAL_PADDING)
            .background(RoundedRectangle(cornerRadius: self.BADGE_CORNER_RADIUS).fill(Color.theme.card))
    }
    
    // MARK: - Block constants
    private let BLOCK_CORNER_RADIUS: CGFloat = 10
    // MARK: - Circle constants
    private let CIRCLE_SIZE: CGFloat = 26
    private let CIRLE_LINE_WIDTH: CGFloat = 2
    private let CIRCLE_TRAILING_PADDING: CGFloat = 10
    // MARK: - Badge constants
    private let BADGE_HORIZONTAL_PADDING: CGFloat  = 7
    private let BADGE_VERTICAL_PADDING: CGFloat  = 4
    private let BADGE_CORNER_RADIUS: CGFloat  = 6
    
    
    enum CompletionStatus {
        case completed, completing, toBeCompleted
    }
}

//struct AuthRegistrationBlockView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            AuthRegistrationBlockView(title: "Personal data", description: "Text Text Text", time: 2, comlpetionStatus: .completed) {}
//
//            AuthRegistrationBlockView(title: "Personal data", description: "Text Text Text", time: 2, comlpetionStatus: .completing) {}
//
//            AuthRegistrationBlockView(title: "Personal data", description: "Text Text Text", time: 2, comlpetionStatus: .toBeCompleted) {}
//        }
//        .previewComponent(with: "AuthRegistrationBlock View", darkOnly: true)
//    }
//}
