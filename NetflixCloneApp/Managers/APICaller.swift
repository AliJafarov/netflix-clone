//
//  APICaller.swift
//  NetflixCloneApp
//
//  Created by Ali Jafarov on 06.04.22.
//

import Foundation

struct Constants {
    static let API_KEY = "7efce30ea03a4076028b894d2bf81e34"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPI_Key = "AIzaSyBOBAw4jawzhJLpwLSBv0tR1rfWwstkqto"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APICaller {
    
    static let shared = APICaller()
    
        
    enum APIError: Error {
            case failedTogetData
        }

        func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
               guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
               let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                   guard let data = data, error == nil else {return}
                   do {
                       let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                       completion(.success(results.results))
                       
                   } catch {
                       completion(.failure(APIError.failedTogetData))
                   }
               }
               
               task.resume()
           }
           
           
        func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
               guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
               let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                   guard let data = data, error == nil else {return}
                   do {
                       let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                       completion(.success(results.results))
                   }
                   catch {
                       completion(.failure(APIError.failedTogetData))
                   }
               }
               task.resume()
           }
           
           
        func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
               guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
               let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                   guard let data = data, error == nil else {return}
                   do {
                       let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                       completion(.success(results.results))
                   } catch {
                       completion(.failure(APIError.failedTogetData))
                   }
               }
               task.resume()
           }
           
        func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
               guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
               let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                   guard let data = data, error == nil else {return}
                   do {
                       let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                       completion(.success(results.results))
                   } catch {
                       completion(.failure(APIError.failedTogetData))
                   }
               }
               task.resume()
           }
           
        func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
               guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return }
               let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                   guard let data = data, error == nil else {return}
                   do {
                       let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                       completion(.success(results.results))

                   } catch {
                       completion(.failure(APIError.failedTogetData))
                   }
               }
               task.resume()
           }
    
    func getDiscover(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getSearchData(with query: String, completion: @escaping (Result<[Title], Error>) -> Void ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
        guard let data = data, error == nil else {return}
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
    task.resume()
  }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        print("YOUTUBE")
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_Key)") else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(YoutubeResult.self, from: data)
                completion(.success(result.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
