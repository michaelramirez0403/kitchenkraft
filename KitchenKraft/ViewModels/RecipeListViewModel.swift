import Foundation
import Dispatch
internal import Combine

@MainActor
final class RecipeListViewModel: ObservableObject {

    enum LoadState: Equatable { case idle, loading, loaded, failed(String) }

    @Published private(set) var state: LoadState = .idle
    @Published private(set) var allRecipes: [Recipe] = []
    @Published private(set) var recipes: [Recipe] = []

    // Inputs
    @Published var searchText: String = "" { didSet { applyLocalFilterIfNeeded() } }
    @Published var vegetarianOnly: Bool = false { didSet { applyLocalFilterIfNeeded() } }
    @Published var servings: Int? = nil { didSet { applyLocalFilterIfNeeded() } }
    @Published var includeIngredientsText: String = "" { didSet { applyLocalFilterIfNeeded() } }
    @Published var excludeIngredientsText: String = "" { didSet { applyLocalFilterIfNeeded() } }
    @Published var instructionSearchText: String = "" { didSet { applyLocalFilterIfNeeded() } }
    
    private var suppressFiltering = false
    private let repository: RecipeRepositoryProtocol

    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }

    func loadInitial() async {
        state = .loading
        do {
            let result = try await repository.getAll()
            allRecipes = result
            state = .loaded
            applyLocalFilter()
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    func resetFilters() {
        suppressFiltering = true
        searchText = ""
        vegetarianOnly = false
        servings = nil
        includeIngredientsText = ""
        excludeIngredientsText = ""
        instructionSearchText = ""
        suppressFiltering = false
        applyLocalFilter()
    }

    private func applyLocalFilter() {
        // Make sure we only filter after data exists (optional guard)
        guard !allRecipes.isEmpty else {
            recipes = []
            return
        }

        let request = RecipeSearchRequest(
            query: searchText,
            vegetarianOnly: vegetarianOnly,
            servings: servings,
            includeIngredients: parseCSV(includeIngredientsText),
            excludeIngredients: parseCSV(excludeIngredientsText),
            instructionQuery: instructionSearchText
        )

        recipes = RecipeSearchEngine.filter(allRecipes, with: request)
    }
    
    private func applyLocalFilterIfNeeded() {
        guard !suppressFiltering else { return }
        applyLocalFilter()
    }

    private func parseCSV(_ text: String) -> [String] {
        text
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}
