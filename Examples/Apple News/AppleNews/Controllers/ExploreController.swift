import Spots
import Brick
import Fakery

class ExploreController: SpotsController {

  convenience init(title: String) {
    let suggestedChannels = Component(span: 3, items: [
      ViewModel(title: "Apple",   kind: Cell.Topic, image: ExploreController.suggestedImage(1)),
      ViewModel(title: "Spotify", kind: Cell.Topic, image: ExploreController.suggestedImage(2)),
      ViewModel(title: "Google",  kind: Cell.Topic, image: ExploreController.suggestedImage(3)),
      ViewModel(title: "Apple",   kind: Cell.Topic, image: ExploreController.suggestedImage(4)),
      ViewModel(title: "Spotify", kind: Cell.Topic, image: ExploreController.suggestedImage(5)),
      ViewModel(title: "Google",  kind: Cell.Topic, image: ExploreController.suggestedImage(6)),
      ViewModel(title: "Apple",   kind: Cell.Topic, image: ExploreController.suggestedImage(7)),
      ViewModel(title: "Spotify", kind: Cell.Topic, image: ExploreController.suggestedImage(8)),
      ViewModel(title: "Google",  kind: Cell.Topic, image: ExploreController.suggestedImage(9))
      ])

    let suggestedTopics = Component(span: 3, items: [
      ViewModel(title: "Business", kind: Cell.Topic, meta: ["color" : "5A0E20"]),
      ViewModel(title: "Software", kind: Cell.Topic, meta: ["color" : "760D26"]),
      ViewModel(title: "News",     kind: Cell.Topic, meta: ["color" : "2266B5"]),
      ViewModel(title: "iOS",      kind: Cell.Topic, meta: ["color" : "4CBCFB"])
      ])

    let browse = Component(title: "Browse", items: [
      ViewModel(title: "News"),
      ViewModel(title: "Business"),
      ViewModel(title: "Politics"),
      ViewModel(title: "Travel"),
      ViewModel(title: "Technology"),
      ViewModel(title: "Sports"),
      ViewModel(title: "Science"),
      ViewModel(title: "Entertainment"),
      ViewModel(title: "Food")
      ], meta: ["headerHeight" : 33])

    let suggestedSpot = CarouselSpot(suggestedChannels)
    suggestedSpot.pageIndicator = true
    suggestedSpot.paginate = true

    let spots: [Spotable] = [
      ListSpot(component: Component(title : "Suggested Channels", meta: ["headerHeight" : 33])),
      suggestedSpot,
      ListSpot(component: Component(title : "Suggested Topics", meta: ["headerHeight" : 33])),
      CarouselSpot(suggestedTopics),
      ListSpot(component: browse)
    ]

    self.init(spots: spots)
    self.title = title
  }

  static func suggestedImage(id: Int) -> String {
    return Faker().internet.image(width: 125, height: 160) + "?item=\(id)"
  }

  static func topicImage(hex: String, id: Int) -> String {
    return Faker().internet.templateImage(width: 125, height: 160, backColorHex: hex, frontColorHex: hex) + "?item=\(id)"
  }
}
