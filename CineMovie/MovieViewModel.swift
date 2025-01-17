//
//  MovieViewModel.swift
//  CineMovie
//
//  Created by Lucas Amorim on 17/01/25.
//

import Foundation
import Combine
import Alamofire
class MovieViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var movies: [Movie] = []  // Para armazenar os filmes
    @Published var movieDetails: MovieDetails?  // Para armazenar detalhes de um filme
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    private let baseUrl = "https://advanced-movie-search.p.rapidapi.com"
    private let headers: HTTPHeaders = [
        "x-rapidapi-key": "b6081b911cmsh80042fcb1c5bd9ap14f466jsn0261e0c16f1e",
        "x-rapidapi-host": "advanced-movie-search.p.rapidapi.com"
    ]

    // Método para obter gêneros
    func fetchGenres() {
        isLoading = true
        print("Fetching genres...")

        AF.request("\(baseUrl)/genre/movie/list", headers: headers)
            .validate()
            .responseDecodable(of: GenreResponse.self) { response in
                switch response.result {
                case .success(let genreResponse):
                    print("Genres fetched successfully!")
                    self.genres = genreResponse.genres
                case .failure(let error):
                    print("Error fetching genres: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
    }

    // Método para buscar filmes por gênero
    func fetchMoviesByGenre(genreId: Int) {
        isLoading = true
        print("Fetching movies by genre...")

        let url = "\(baseUrl)/discover/movie?with_genres=\(genreId)&page=1"
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .success(let movieListResponse):
                    print("Movies fetched successfully!")
                    self.movies = movieListResponse.results
                case .failure(let error):
                    print("Error fetching movies by genre: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
    }

    // Método para buscar detalhes do filme
    func fetchMovieDetails(movieId: Int) {
        isLoading = true
        print("Fetching movie details...")

        let url = "\(baseUrl)/movies/getdetails?movie_id=\(movieId)"
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: MovieDetails.self) { response in
                switch response.result {
                case .success(let details):
                    print("Movie details fetched successfully!")
                    self.movieDetails = details
                case .failure(let error):
                    print("Error fetching movie details: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
    }
}
