class FavoriteCardEntity {
  final String? image;
  final String? name;
  final String? address;
  final bool? status;
  final bool? isFavorite;

  FavoriteCardEntity({
    this.image,
    this.name,
    this.address,
    this.status,
    this.isFavorite,
  });
}

List<FavoriteCardEntity> favoriteCardEntityList = [
  FavoriteCardEntity(
    image:
        "https://i.pinimg.com/736x/ed/1f/7f/ed1f7f27346ac0599c44b2109392ea77.jpg",
    name: "Starbucks",
    address: "17 Motijheel C/A, Dhaka 1000",
    status: false,
    isFavorite: true,
  ),
  FavoriteCardEntity(
    image:
        "https://i.pinimg.com/736x/d0/00/99/d00099a7c5ec249782b89529708eff4b.jpg",
    name: "North End Coffee",
    address: "House 5, Road 11, Banani, Dhaka",
    status: true,
    isFavorite: false,
  ),
  FavoriteCardEntity(
    image:
        "https://i.pinimg.com/736x/28/89/1b/28891bd21752075dd7d18fc89d704207.jpg",
    name: "Tabaq Coffee",
    address: "Dhanmondi 27, Dhaka",
    status: true,
    isFavorite: true,
  ),
  FavoriteCardEntity(
    image:
        "https://i.pinimg.com/1200x/b7/08/22/b70822abc99cecf1180092f0fb89683b.jpg",
    name: "Gloria Jean’s Coffees",
    address: "Jamuna Future Park, Dhaka",
    status: false,
    isFavorite: false,
  ),
  FavoriteCardEntity(
    image:
        "https://i.pinimg.com/736x/7a/ae/56/7aae5615ad7c323585cd1752e814d3ba.jpg",
    name: "Coffee World",
    address: "Bashundhara R/A, Dhaka",
    status: true,
    isFavorite: false,
  ),
  FavoriteCardEntity(
    image:
        "https://i.pinimg.com/736x/29/2f/39/292f39c0affc11c17773eec5234d7e79.jpg",
    name: "Crimson Cup",
    address: "Uttara Sector 7, Dhaka",
    status: true,
    isFavorite: true,
  ),
];
