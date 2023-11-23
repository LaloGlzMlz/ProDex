import SwiftUI

struct PokemonDetailView: View {
    @State private var currentProgressHP: CGFloat = 0.43
    @State private var currentProgressATK: CGFloat = 0.44
    @State private var currentProgressDEF: CGFloat = 0.43
    @State private var currentProgressSATK: CGFloat = 0.48
    @State private var currentProgressSDEF: CGFloat = 0.44
    @State private var currentProgressSPE: CGFloat = 0.47
    @State private var currentProgressTOT: CGFloat = 0.89
    let multiplier: CGFloat = 100
    let pokemonId: Int
    @ObservedObject private var viewModel = PokemonDetailViewModel()
    @ObservedObject private var pokemonService = PokemonService()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack{
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.red.opacity(1.0), location: 0.0),
                                    .init(color: Color.red.opacity(0.0), location: 1.0)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                                ))
                            .frame(width: geometry.size.width, height: 200) // Adjust the size of the square as needed
                            .offset(y: -40)
                    }.ignoresSafeArea()
                    
                    // Official Artwork
                    if let officialArtworkURL = viewModel.pokemonDetails?.sprites.other.officialArtwork.frontDefault {
                        AsyncImage(url: officialArtworkURL) { phase in
                            switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity, maxHeight: 350) // Adjust the frame size as needed
                                case .failure:
                                    Image(systemName: "pkball") // Placeholder image for failure
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity, maxHeight: 280) // Adjust the frame size as needed
                            }
                        }.offset(y: -45) // Adjust the value as needed
                    } // Official Artwork ends
                }
                
                VStack(alignment: .leading) {
                    // Display fetched details
                    if let details = viewModel.pokemonDetails {
                        
                        Text("#\(pokemonId)")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                            .padding(.bottom, 1)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        Text(details.name.capitalized)
                            .font(.system(size: 40).bold())
                            .padding(.bottom, 13)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        HStack{
                            ZStack {
                                Capsule()
                                    .fill(Color(.fire))
                                    .frame(width: 135, height: 40)
                                    .padding(.bottom, 1)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 5)
                                    .overlay(
                                        Image("fire")
                                            .resizable()
                                            .frame(width: 33,height: 33)
                                            .offset(x: -38)
                                    )
                                    .overlay(
                                        Text("Fire")
                                            .font(.system(size: 20)).bold()
                                            .foregroundColor(.white) // Adjust the font as needed
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                            .padding(.leading, 20)
                                            .offset(x: 7)
                                )
                            }
                            Capsule()
                                .fill(Color(.flying))
                                .frame(width: 135, height: 40)
                                .padding(.bottom, 1)
                                .padding(.leading, 5)
                                .padding(.trailing, 10)
                                .overlay(
                                    Image("flying")
                                        .resizable()
                                        .frame(width: 33,height: 33)
                                        .offset(x: -49)
                                )
                                .overlay(
                                    Text("Flying")
                                        .font(.system(size: 20)).bold()
                                        .foregroundColor(.white) // Adjust the font as needed
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .offset(x: 10)
                                )
                        }
                        Text("Stats")
                            .font(.system(size: 30).bold())
                            .padding(.top, 30)
                            .padding(.bottom, 0.5)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("HP")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressHP * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressHP)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            HStack {
                                Text("ATK")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressATK * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressATK)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            HStack {
                                Text("DEF")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressDEF * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressDEF)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            HStack {
                                Text("SATK")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressATK * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressSATK)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            HStack {
                                Text("SDEF")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressDEF * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressSDEF)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            HStack {
                                Text("SPE")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressSPE * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressSPE)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            HStack {
                                Text("TOT")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.fire))
                                Spacer()
                                Text("\(Int(currentProgressTOT * multiplier))")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(Color(.gray))
                                Spacer()
                                ProgressBarView(progress: $currentProgressTOT)
                                    .frame(height: 25)
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                        }
                    }
                }.offset(y: -60)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                // frontDefault sprite
                if let officialArtworkURL = viewModel.pokemonDetails?.sprites.frontDefault {
                    AsyncImage(url: officialArtworkURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "pkball") // Placeholder image for failure
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 280) // Adjust the frame size as needed
                        }
                    }
                }
            }
        }
        .onAppear {
            // Call the function to fetch Pokemon details when the view appears
            viewModel.fetchPokemonDetails(for: pokemonId)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonId: 6) // Provide a valid Pokemon ID for the preview
    }
}
