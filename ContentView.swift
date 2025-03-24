import SwiftUI

struct Musica: Identifiable {
    var id: Int
    var titulo: String
    var artista: String
    var imagem: String
}

struct ContentView: View {
    let musicas = [
        Musica(id: 1, titulo: "Blank Space", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s"),
        Musica(id: 2, titulo: "Welcome To New York", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s"),
        Musica(id: 3, titulo: "Bad Blood", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s"),
        Musica(id: 4, titulo: "Wildest Dreams", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s"),
        Musica(id: 5, titulo: "Blank Space", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s"),
        Musica(id: 6, titulo: "New Romantics", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s"),
        Musica(id: 7, titulo: "Out Of The Woods", artista: "Taylor Swift", imagem: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s")
    ]
    
    @State private var showSugestoes = false // Controla a visibilidade de "Sugeridos"
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fundo com gradiente
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    // Imagem centralizada no topo
                    AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRbNXC6cbEdiX5-LM6f91I3slFeZMifFG5g&s")) { phase in
                        if let imagem = phase.image {
                            imagem.resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300) // Ajustando o tamanho da imagem
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.top, 60) // Ajuste para afastar a imagem do topo
                        } else if phase.error != nil {
                            Text("Erro ao carregar imagem")
                        } else {
                            ProgressView() // Indicador de carregamento
                        }
                    }
                    
                    // Texto: "1989 (Taylor's Version)"
                    HStack {
                        Text("1989 (Taylor's Version)")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .padding(.top, 20)
                        Spacer()
                    }
                    
                    // Texto: "My songs" com imagem ao lado
                    HStack {
                        AsyncImage(url: URL(string: "https://t2.tudocdn.net/650666?w=824&h=494")) { phase in
                            if let imagem = phase.image {
                                imagem.resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40) // Imagem quadrangular
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else if phase.error != nil {
                                Text("Erro ao carregar imagem")
                            } else {
                                ProgressView() // Indicador de carregamento
                            }
                        }
                        Text("MySongs")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.top, 5)
                        Spacer()
                    }
                    
                    // Lista de músicas com fundo transparente
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(musicas) { musica in
                                NavigationLink(destination: MusicaDetalhesView(musica: musica)) {
                                    HStack {
                                        AsyncImage(url: URL(string: musica.imagem)) { phase in
                                            if let imagem = phase.image {
                                                imagem.resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50) // Ajuste o tamanho da imagem conforme necessário
                                                    .clipShape(RoundedRectangle(cornerRadius: 10)) // Para deixar a imagem arredondada
                                            } else if phase.error != nil {
                                                Text("Erro ao carregar imagem")
                                            } else {
                                                ProgressView() // Indicador de carregamento
                                            }
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            // Verificando se o título é maior que 20 caracteres
                                            if musica.titulo.count > 20 {
                                                Text(String(musica.titulo.prefix(20)) + "...")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 5)
                                            } else {
                                                Text(musica.titulo)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                            }

                                            Text(musica.artista)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            
                                            HStack {
                                                Spacer() // Adiciona um espaço à esquerda para alinhar o ícone à direita
                                                Image(systemName: "ellipsis")
                                                    .foregroundColor(.black) // Define a cor preta para a elipse
                                            }
                                        }
                                        .padding(.vertical, 5)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(0), Color.clear]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                        .cornerRadius(10)
                                    )
                                    .padding(.bottom, 5)
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        // Quando o usuário rola até o final, mostramos a seção "Sugeridos"
                        .onChange(of: musicas.count) { _ in
                            showSugestoes = true
                        }
                    } // Fim do ScrollView
                    
                    // Seção Sugeridos, apenas visível quando showSugestoes é verdadeiro
                    if showSugestoes {
                        Text("Sugeridos")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.top, 20)
                        
                        // ScrollView horizontal de sugestões de álbuns
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(musicas) { musica in
                                    AsyncImage(url: URL(string: musica.imagem)) { phase in
                                        if let imagem = phase.image {
                                            imagem.resizable()
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        } else if phase.error != nil {
                                            Text("Erro ao carregar imagem")
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

struct MusicaDetalhesView: View {
    var musica: Musica
    
    var body: some View {
        ZStack {
            // Fundo com gradiente
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Botão de Voltar
                HStack {
                    Button(action: {
                    }) {
                        
                    }
                    Spacer()
                }
                .padding(.top, 40)
                
                // Imagem da capa da música
                AsyncImage(url: URL(string: musica.imagem)) { phase in
                    if let imagem = phase.image {
                        imagem.resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300) // Ajustando o tamanho da imagem
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 20)
                    } else if phase.error != nil {
                        Text("Erro ao carregar imagem")
                    } else {
                        ProgressView() // Indicador de carregamento
                    }
                }
                
                // Nome do artista e título
                VStack {
                    Text(musica.titulo)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.top, 20)
                    
                    Text(musica.artista)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                
                // Controles de música
                HStack {
                    Image(systemName: "shuffle")
                        .font(.title)
                        .foregroundColor(.white)
                    Image(systemName: "backward.end.fill")
                        .font(.title)
                        .foregroundColor(.white)
                    Image(systemName: "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                    Image(systemName: "forward.end.fill")
                        .font(.title)
                        .foregroundColor(.white)
                    Image(systemName: "repeat")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

