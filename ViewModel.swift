import Foundation

class ViewModel: ObservableObject {
    
    @Published var objeto: [Dados] = []
    
    func fetch() {
        guard let url = URL(string: "http://192.168.128.25:1880/localhostGet") else {
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
                let parsed = try JSONDecoder().decode([Dados].self, from: data)
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
