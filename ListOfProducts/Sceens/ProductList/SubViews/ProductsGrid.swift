//
//  Products.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//
import SwiftUI
import Combine

struct ProductsGridView: View {
    @EnvironmentObject var user: User
    @Environment(\.injected) private var injected: DIContainer
    @State var products: [Product] = []
    @State var productsUpdtaesInfo:  Loadable<[Product]>

    @State private(set) var productsState: Loadable<[Product]>
    @State private(set) var stateofProductChanged: Loadable<Product>
    
    @State private var selectedScreen: Screen?
    @State private var navigationPath = NavigationPath()
    
    
    init(state: Loadable<[Product]> = .notRequested) {
        self._productsState = .init(initialValue: state)
        self._stateofProductChanged = .init(initialValue: .notRequested)
        self._productsUpdtaesInfo = .init(initialValue: .notRequested)
    }
    
    var body: some View {
        content
    }
    
    @ViewBuilder private var content: some View {
        switch productsState {
        case .notRequested:
            defaultView()
        case .isLoading:
            loadingView()
        case let .loaded(productsInfo):
            loadedView(products: productsInfo)
        case let .failed(error):
            failedView(error)
        }
    }
    
}

#Preview {
    ProductsGridView()
}

private extension ProductsGridView {
    @ViewBuilder
    func loadedView( products: [Product]) -> some View {
        NavigationStack (path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 2), spacing: 8) {
                    ForEach(products.indices, id: \.self) { index in
                        ProductView(product: products[index],
                                    isFavorite: products[index].isFavorite,
                                    onToggle: {
                            deleteOrAddToProductFaviorates(productId: products[index].id,
                                                           isFavorite: !products[index].isFavorite)
                        })
                    }
                }
                .navigationTitle(Text("New In"))
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing){
                        Button(action: {
                            navigationPath.append(Screen.wishList)
                        }) {
                            Image(systemName: "heart")
                                .foregroundColor(.black)
                        }
                    }
                }
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .wishList:
                        WishListView()
                            .onDisappear {
                                loadProductsList(forceReload: false)
                            }
                    }
                }
            }
        }
        .onReceive(productsUpdate) { update in
            self.productsUpdtaesInfo = update
        }
        
    }
    
    func defaultView() -> some View {
        Text("No products in your wish list")
            .onAppear {
                if !products.isEmpty {
                    productsState = .loaded(products)
                }
                loadProductsList(forceReload: false)
            }
    }
    
    func loadingView() -> some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            loadProductsList(forceReload: false)
        })
    }
}

private extension ProductsGridView {
    
    private func loadProductsList(forceReload: Bool) {
        guard forceReload || products.isEmpty else { return }
        $productsState.load {
            try await  injected.viewModels.productViewModel.fetchData( userId: "68150b6a29021b5984886601")
        }
    }
    
    private func deleteOrAddToProductFaviorates(productId: String, isFavorite: Bool) {
        $stateofProductChanged.load {
            try await  injected.viewModels.productViewModel.onToggle(userId: "68150b6a29021b5984886601",
                                                                     productId: productId, isFavorite: isFavorite)
        }
    }
    
    var productsUpdate: AnyPublisher<Loadable<[Product]>, Never> {
        injected.appState.updates(for: \.userData.products)
    }
    
}
