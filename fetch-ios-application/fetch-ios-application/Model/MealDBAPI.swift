import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()

    func fetchMeals(completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
                    completion(.success(decodedResponse.meals))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }

    func fetchMealDetails(id: String, completion: @escaping (Result<Meal, NetworkError>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
                    if let meal = decodedResponse.meals.first {
                        completion(.success(meal))
                    } else {
                        completion(.failure(.decodingError))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }
}
