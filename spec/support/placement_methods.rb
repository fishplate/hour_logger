def given_placement
  @placement ||= Placement.create!(name: "some_name", area: "some_area")
end