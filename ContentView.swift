import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        //ZStack {
        HStack {
            AsyncImage(url: URL(string: "https://tomi-digital-resources.storage.googleapis.com/images/classes/resources/rsc-441529-5f98b44a8ff63.jpeg")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle()) // Deixa a imagem circular
            } placeholder: {
                ProgressView() // Mostra um indicador de carregamento enquanto a imagem baixa
            }
            
            Text("Welcome to Tasks")
                .bold()
                .font(.title)
            
        }
        

            .padding()
            
            Spacer()
            
            VStack {
                if viewModel.objeto.isEmpty {
                    Text("Carregando...")
                } else {
                    List(viewModel.objeto, id: \.self) { item in
                        Text(item.disciplina ?? "Sem disciplina")
                            .font(.headline)
                            .padding(3)
                        
                        if let tarefas = item.tarefa {
                            ForEach(tarefas, id: \.self) { tarefa in
                                Text("• Tarefa: \(tarefa)\n" + "• Data: \(item.data ?? "Sem Data")")
                                    .font(.body)
                                    .padding(.leading, 10)
                                     }
                            }
                        }
                    }
                }
            
        .onAppear {
            viewModel.fetch()
        }

    }
}

#Preview {
    ContentView()
}
