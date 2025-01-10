func fetchData(completion: @escaping (Result<[Data], Error>) -> Void) {
    let group = DispatchGroup()
    var dataArray: [Data] = []
    var error: Error?

    for i in 0..<10 {
        group.enter()
        URLSession.shared.dataTask(with: URL(string: "https://api.example.com/data/"
                                            + String(i))!) { data, response, urlError in
            defer { group.leave() }
            if let urlError = urlError {
                error = urlError
                return
            }
            if let data = data {
                dataArray.append(data)
            }
        }.resume()
    }

    group.notify(queue: .main) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(dataArray))
        }
    }
}