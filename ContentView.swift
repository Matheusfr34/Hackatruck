import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            // Imagem de fundo ocupando a parte superior da tela
            AsyncImage(url: URL(string: "https://kanto.legiaodosherois.com.br/w760-h398-cfill/wp-content/uploads/2016/01/9441ced3e5ff320a6de3b653cf00ac57.jpg.webp")) { image in
                image.resizable()
                    .scaledToFill()  // Preenche a tela com a imagem
                    .frame(height: 300)  // Define a altura da imagem
                    .clipped()  // Garante que a imagem não ultrapasse os limites
                    .ignoresSafeArea(edges: .top)  // Ignora a área segura da parte superior da tela
            } placeholder: {
                ProgressView() // Mostra um indicador de carregamento enquanto a imagem não é carregada
            }
            
            // Espaço para empurrar o conteúdo para baixo
            Spacer()

            // ScrollView para mostrar os personagens
            ScrollView {
                ForEach(viewModel.personagens) { index in
                    HStack {
                        // Exibe a imagem do personagem
                        AsyncImage(url: URL(string: index.image!)) { image in
                            image.resizable()
                                .scaledToFit() // Ajusta o tamanho da imagem
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())  // Deixa a imagem em formato circular

                        // Exibe o nome do personagem
                        VStack(alignment: .leading) {
                            Text(index.name ?? "Nome não disponível")
                                .foregroundColor(.black) // Cor do texto
                                .padding(.leading, 10) // Espaçamento à esquerda do texto
                        }

                        Spacer() // Garante que a imagem e o nome ocupem o espaço desejado

                    }
                    .padding()  // Adiciona padding ao redor de cada HStack

                }
            }
            .padding()
        }
        .onAppear() {
            viewModel.fetch() // Chama a função de fetch quando a view aparece
        }
    }
}

#Preview {
    ContentView()
}
