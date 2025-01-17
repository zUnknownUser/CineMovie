//
//  ContentView.swift
//  CineMovie
//
//  Created by Lucas Amorim on 17/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var selectedGenreId: Int?

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                if let selectedGenreId = selectedGenreId {
                    // Exibindo filmes por gênero
                    List(viewModel.movies) { movie in
                        Text(movie.title)
                            .onTapGesture {
                                viewModel.fetchMovieDetails(movieId: movie.id)
                            }
                    }
                } else {
                    List(viewModel.genres) { genre in
                        Text(genre.name)
                            .onTapGesture {
                                self.selectedGenreId = genre.id
                                viewModel.fetchMoviesByGenre(genreId: genre.id)
                            }
                    }
                }

                if let movieDetails = viewModel.movieDetails {
                    VStack {
                        Text(movieDetails.title)
                            .font(.largeTitle)
                        Text("Release Date: \(movieDetails.release_date)")
                        Text(movieDetails.overview)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchGenres()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

