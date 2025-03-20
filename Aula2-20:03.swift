import SwiftUI

struct Aula2_20_03: View {
    @State private var distancia: String = ""
    @State private var tempo: String = ""
    @State private var velocidade: Double? = nil
    @State private var corFundo: Color = .gray
    @State private var imagem: String = "images-6" // Imagem padrão antes da velocidade ser calculada
    
    var body: some View {
        VStack {
            // Texto para a distância
            Text("Digite a distância (km):")
                .font(.headline)
            
            // Campo de texto para inserir a distância
            TextField("Insira a distância", text: $distancia)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            // Texto para o tempo
            Text("Digite o tempo (h):")
                .font(.headline)
            
            // Campo de texto para inserir o tempo
            TextField("Insira o tempo", text: $tempo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            // Botão para calcular a velocidade
            Button(action: calcularVelocidade) {
                Text("Calcular")
                    .font(.title3)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            
            // Exibição da velocidade calculada
            if let velocidade = velocidade {
                Text("Velocidade: \(String(format: "%.2f", velocidade)) km/h")
                    .font(.title2)
                    .padding()
            }
            
            // Exibindo a imagem, que será alterada conforme a velocidade
            Image(imagem) // Mudando a imagem conforme a velocidade
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.top, 20)

            
            Spacer()

            VStack(spacing: 10) {
                HStack {
                    Circle()
                        .fill(Color(hex: "#ABFFAC")) // Cor verde claro
                        .frame(width: 15, height: 15)
                    Text("TARTARUGA: 0 - 9.9 km/h")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                // ELEFANTE
                HStack {
                    Circle()
                        .fill(Color(hex: "#ACFFF2")) // Cor laranja
                        .frame(width: 15, height: 15)
                    Text("ELEFANTE: 10 - 29.9 km/h")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                // AVESTRUZ
                HStack {
                    Circle()
                        .fill(Color(hex: "FFC5A6"))
                        .frame(width: 15, height: 15)
                    Text("AVESTRUZ: 30 - 69.9 km/h")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                // LEÃO
                HStack {
                    Circle()
                        .fill(Color(hex: "#EEFFA4"))
                        .frame(width: 15, height: 15)
                    Text("LEÃO: 70 - 89.9 km/h")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                // GUEPARDO
                HStack {
                    Circle()
                        .fill(Color(hex: "#FF7764"))
                        .frame(width: 15, height: 15)
                    Text("GUEPARDO: 90 - 130 km/h")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .background(Color.black)
            .cornerRadius(10)
            .padding()
        }
        .background(corFundo)
    }
    
    // Função que calcula a velocidade e altera a imagem e cor de fundo conforme a velocidade
    func calcularVelocidade() {
        let distanciaDouble = Double(distancia) ?? 0
        let tempoDouble = Double(tempo) ?? 1
        velocidade = distanciaDouble / tempoDouble
        
        if let velocidade = velocidade {
            // Condições para determinar a cor e a imagem com base na velocidade
            if velocidade < 10 {
                corFundo = Color(hex: "#ABFFAC")
                imagem = "images-1"
            } else if velocidade < 30 {
                corFundo = Color(hex: "#ACFFF2")
                imagem = "images-2"
            } else if velocidade < 70 {
                corFundo = Color(hex: "FFC5A6")
                imagem = "images-3"
            } else if velocidade < 90 {
                corFundo = Color(hex: "#EEFFA4")
                imagem = "images-4"
            } else {
                corFundo = Color(hex: "#FF7764")
                imagem = "images-5"
            }
        }
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    Aula2_20_03()
}
