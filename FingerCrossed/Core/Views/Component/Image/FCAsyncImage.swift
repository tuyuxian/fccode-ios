//
//  FCAsyncImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/19/23.
//

import SwiftUI

enum PhotoType {
    case landscape
    case portrait
    case square
}

struct FCAsyncImage: View {
    
    @State private var phase: AsyncImagePhase
    
    @State private var shouldFit: Bool = false
    
    let urlRequest: URLRequest
    
    var session: URLSession = .imageSession
    
    var photoType: PhotoType = .landscape
    
    init(
        url: URL,
        session: URLSession = .imageSession
    ) {
        self.session = session
        
        self.urlRequest = URLRequest(url: url)
        
        if let data = session.configuration.urlCache?.cachedResponse(for: urlRequest)?.data,
           let uiImage = UIImage(data: data) {
            
            if uiImage.size.width > uiImage.size.height {
                self.photoType = .landscape
            } else if uiImage.size.height > uiImage.size.width {
                self.photoType = .portrait
            } else {
                self.photoType = .square
            }
            
            if uiImage.size.width >= uiImage.size.height {
                _shouldFit = .init(wrappedValue: true)
            }
            _phase = .init(wrappedValue: .success(.init(uiImage: uiImage)))
        } else {
            _phase = .init(wrappedValue: .empty)
        }
    }
    
    var body: some View {
        Group {
            switch phase {
            case .empty:
                Shimmer().task { await load() }
            case .success(let image):
                if shouldFit {
                    image.resizable().scaledToFit()
                } else {
                    image.resizable().scaledToFill()
                }
            case .failure:
                Shimmer()
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func load() async {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode,
                  let uiImage = UIImage(data: data)
            else {
                throw FCError.LifePhoto.downloadFailed
            }
            
            withAnimation(.spring()) {
                phase = .success(.init(uiImage: uiImage))
            }
        } catch {
            phase = .failure(error)
        }
    }
}

struct FCAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        FCAsyncImage(
            url: URL(string: "https://i.pravatar.cc/150?img=5")!
        )
        .frame(width: 100, height: 100)
    }
}
