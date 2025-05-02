//
//  ArticleDetailView.Swift
//  SpaceFlightNew
//
//  Created by Amini on 01/05/25.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Cover Image
                if let imageURL = article.imageURL {
                    ImageLoaderView(url: imageURL)
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(12)
                        .shadow(radius: 10)
                }

                Text(article.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])

                Text("By Author • \(formattedDate())")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                Text(article.summary ?? "")
                    .font(.body)
                    .lineSpacing(8)
                    .padding([.top, .horizontal])
                    .multilineTextAlignment(.leading)

                HStack {
                    Button(action: {
                        // Share action
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading)

                    Spacer()

                    Button(action: {
                        // Save action
                    }) {
                        Label("Save", systemImage: "star.fill")
                            .font(.title2)
                            .foregroundColor(.yellow)
                    }
                    .padding(.trailing)
                }

                Divider()

                // Comments Section (Optional)
                Text("Comments")
                    .font(.headline)
                    .padding([.top, .horizontal])

                // Sample Comments (Optional)
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(0..<3, id: \.self) { _ in
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text("User Name")
                                    .fontWeight(.bold)
                                Text("Great article, very insightful!")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Article Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Helper function to format the date
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: Date()) // Placeholder for actual date from article
    }
}


//#Preview {
//    ArticleDetailView(
//        article: Article(
//            id: UUID(),
//            title: "Understanding SwiftUI 3",
//            thumbnail: "thumb1",  // Replace with your image name
//            content: "SwiftUI 3 introduces a lot of new features...",
//            author: "John Doe",
//            publishedDate: Date()
//        )
//    )
//}
