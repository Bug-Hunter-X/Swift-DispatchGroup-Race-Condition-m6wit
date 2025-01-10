func fetchData(completion: @escaping (Result<[Data], Error>) -> Void) {
    let group = DispatchGroup()
    var dataArray: [Data] = []
    var errors: [Error] = []

    let dispatchQueue = DispatchQueue(label: "fetchDataQueue", attributes: .concurrent)

    for i in 0..<10 {
        group.enter()
        dispatchQueue.async {
            URLSession.shared.dataTask(with: URL(string: "https://api.example.com/data/"
                                                + String(i))!) { data, response, urlError in
                defer { group.leave() }
                if let urlError = urlError {
                    errors.append(urlError)
                }
                if let data = data {
                    dataArray.append(data)
                }
            }.resume()
        }
    }

    group.notify(queue: .main) {
        if errors.isEmpty {
            completion(.success(dataArray))
        } else {
            completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Multiple network errors occurred."])))
        }
    }
}

//Example usage:
fetchData { result in
    switch result {
    case .success(let data):
        print("Successfully fetched data:", data)
    case .failure(let error):
        print("Error fetching data:", error)
    }
}