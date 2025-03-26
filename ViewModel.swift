import Foundation


class ViewModel: ObservableObject { // Conforma com ObservableObject para ser reativo no SwiftUI
    
    // @Published: Notifica a interface do SwiftUI sempre que o array de personagens for atualizado
    @Published var personagens: [HaPo] = []
    
    // Função responsável por buscar os personagens da API
    func fetch() {
        
        // Define a URL da API que retorna personagens da casa Grifinória
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters/house/gryffindor") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([HaPo].self, from: data)
                
                DispatchQueue.main.async {
                    self?.personagens = parsed
                }
            } catch {
                
                print(error)
            }
        }
        
        // Inicia a requisição HTTP
        task.resume()
    }
}
