class PropertyDetails {
  const PropertyDetails({
    required this.title,
    required this.address,
    required this.propertyTax,
    required this.maintenanceCost,
    required this.rentalIncome,
    required this.appreciation,
    this.otherDetails = const {},
  });
  final String title;
  final String address;
  final double propertyTax;
  final double maintenanceCost;
  final double rentalIncome;
  final double appreciation;
  final Map<String, List<String>> otherDetails;
  //The List will Contain the Image Vector(formatted into 64 bit maybe)
  //or just the network Image url. Map maps the Property title like bed,bath,Area. List has icon on 0th index, Value in 1st.
}
