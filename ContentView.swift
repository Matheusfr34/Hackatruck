import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Histórico de Umidade:")
                    .font(.headline)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.objeto, id: \.self) { item in
                            Text(item.umidade ?? "Sem valores")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Dados de Umidade")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
