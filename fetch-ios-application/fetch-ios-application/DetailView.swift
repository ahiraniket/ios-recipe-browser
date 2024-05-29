import SwiftUI

struct DetailView: View {
    let mealID: String
    @State private var meal: Meal?
    @State private var isLoading = true

    var ingredients: [String?] {
        [
            meal?.strIngredient1, meal?.strIngredient2, meal?.strIngredient3, meal?.strIngredient4, meal?.strIngredient5,
            meal?.strIngredient6, meal?.strIngredient7, meal?.strIngredient8, meal?.strIngredient9, meal?.strIngredient10,
            meal?.strIngredient11, meal?.strIngredient12, meal?.strIngredient13, meal?.strIngredient14, meal?.strIngredient15,
            meal?.strIngredient16, meal?.strIngredient17, meal?.strIngredient18, meal?.strIngredient19, meal?.strIngredient20
        ]
    }

    var measures: [String?] {
        [
            meal?.strMeasure1, meal?.strMeasure2, meal?.strMeasure3, meal?.strMeasure4, meal?.strMeasure5,
            meal?.strMeasure6, meal?.strMeasure7, meal?.strMeasure8, meal?.strMeasure9, meal?.strMeasure10,
            meal?.strMeasure11, meal?.strMeasure12, meal?.strMeasure13, meal?.strMeasure14, meal?.strMeasure15,
            meal?.strMeasure16, meal?.strMeasure17, meal?.strMeasure18, meal?.strMeasure19, meal?.strMeasure20
        ]
    }

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            } else if let meal = meal {
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottomLeading) {
                        URLImage(url: meal.strMealThumb)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                            .clipped()

                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .center
                        )
                        .frame(height: 200)
                        
                        Text(meal.strMeal)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.leading, .bottom], 16)
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Instructions")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        
                        Text(meal.strInstructions ?? "No instructions available.")
                            .foregroundColor(.secondary)
                        
                        Text("Ingredients")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(Array(zip(ingredients, measures)), id: \.0) { ingredient, measure in
                                if let ingredient = ingredient, let measure = measure, !ingredient.isEmpty, !measure.isEmpty {
                                    HStack {
                                        
                                        Text("\(ingredient):")
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                        Text(measure)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(8)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .background(Color(.systemBackground))
                .padding()
            } else {
                Text("Failed to load meal details.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        .navigationTitle("Meal Details")
        .onAppear(perform: loadMealDetails)
    }

    func loadMealDetails() {
        NetworkManager.shared.fetchMealDetails(id: mealID) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let meal):
                    self.meal = meal
                case .failure(let error):
                    print("Error fetching meal details: \(error)")
                }
            }
        }
    }
}

struct URLImage: View {
    let url: String
    @State private var imageData: Data?

    var body: some View {
        Group {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            } else {
                print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
