import Foundation

class ViewModel: ObservableObject {
    
    @Published var objeto: [obj] = []
    
    func fetch() {
        guard let url = URL(string: "http://127.0.0.1:1880/localhostGet") else {
            print("URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro na requisição: \(error)")
                return
            }
            
            guard let data = data else {
                print("Dados vazios")
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([obj].self, from: data)
                DispatchQueue.main.async {
                    self.objeto = parsed
                }
            } catch {
                print("Erro ao decodificar JSON: \(error)")
            }
        }
        task.resume() 
    }
}
