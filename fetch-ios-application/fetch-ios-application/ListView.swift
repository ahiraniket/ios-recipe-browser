import SwiftUI

struct ListView: View {
    @State private var meals: [Meal] = []
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else {
                    List(meals) { meal in
                        NavigationLink(destination: DetailView(mealID: meal.idMeal)) {
                            HStack(spacing: 25) {
                                URLImage(url: meal.strMealThumb)
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(8)
                                    .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 2)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(meal.strMeal)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding(.vertical, 7)
                    }
                    .navigationTitle("Desserts")
                }
            }
            .onAppear(perform: loadMeals)
        }
    }

    func loadMeals() {
        NetworkManager.shared.fetchMeals { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let meals):
                    self.meals = meals
                case .failure(let error):
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }
}
