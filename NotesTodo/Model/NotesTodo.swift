import Foundation

struct NotesTodo: Identifiable, Hashable {
  let id: UUID
  let text: String
  let date: Date
}

extension NotesTodo {
  static let sample: [Self] = [
    NotesTodo(id: .init(), text: "Lorem ipsum dolor\n sit amet, consectetuer adipiscing elit. Nunc auctor. Pellentesque sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aliquam erat volutpat. Mauris tincidunt sem sed arcu. Integer tempor. Etiam commodo dui eget wisi. Etiam sapien elit, consequat eget, tristique non, venenatis", date: .now),
    NotesTodo(id: .init(), text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Donec vitae arcu. Mauris dolor felis, sagittis at, luctus sed, aliquam non, tellus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec vitae arcu. Etiam posuere lacus quis dolor. Mauris elementum mauris vitae tortor. In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. Aenean placerat. Proin mattis lacinia justo. Fusce tellus. Integer malesuada. Vivamus ac leo pretium faucibus. Nullam dapibus fermentum ipsum. Curabitur ligula sapien, pulvinar a vestibulum quis, facilisis vel sapien.", date: .now),
    NotesTodo(id: .init(), text: "Nam quis nulla. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus. Etiam posuere lacus quis dolor. Pellentesque sapien. Cras elementum. Aliquam id dolor. Etiam commodo dui eget wisi. Mauris dictum facilisis augue. Aenean fermentum risus id tortor. Quisque tincidunt scelerisque libero. Curabitur vitae diam non enim vestibulum interdum. Nullam eget nisl. Etiam posuere lacus quis dolor. Integer lacinia. Nullam at arcu a est sollicitudin euismod. Etiam quis quam. Integer lacinia.", date: .now),
    NotesTodo(id: .init(), text: "Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac, erat. Sed ac dolor sit amet purus malesuada congue. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Fusce tellus. Etiam dictum tincidunt diam. Maecenas lorem. Curabitur ligula sapien, pulvinar a vestibulum quis, facilisis vel sapien. Quisque tincidunt scelerisque libero. Praesent in mauris eu tortor porttitor accumsan. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Pellentesque ipsum. Ut tempus purus at lorem. Curabitur bibendum justo non orci. Mauris dolor felis, sagittis at, luctus sed, aliquam non, tellus.", date: .now),
    NotesTodo(id: .init(), text: "Nullam sit amet magna in magna gravida vehicula. Pellentesque ipsum. Fusce nibh. Sed convallis magna eu sem. Proin mattis lacinia justo. Nam sed tellus id magna elementum tincidunt. Integer rutrum, orci vestibulum ullamcorper ultricies, lacus quam ultricies odio, vitae placerat pede sem sit amet enim. Suspendisse nisl. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci.", date: .now),
    NotesTodo(id: .init(), text: "Integer rutrum, orci vestibulum ullamcorper ultricies, lacus quam ultricies odio, vitae placerat pede sem sit amet enim. Integer malesuada. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. Duis condimentum augue id magna semper rutrum. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Nullam dapibus fermentum ipsum. Nulla est. Aliquam ornare wisi eu metus. Curabitur sagittis hendrerit ante. Nulla non lectus sed nisl molestie malesuada. Integer vulputate sem a nibh rutrum consequat. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Maecenas aliquet accumsan leo. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Donec vitae arcu.", date: .now),
    NotesTodo(id: .init(), text: "Proin pede metus, vulputate nec, fermentum fringilla, vehicula vitae, justo. Fusce nibh. Quisque tincidunt scelerisque libero. Integer imperdiet lectus quis justo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam ornare wisi eu metus. Fusce wisi. Donec quis nibh at felis congue commodo. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Etiam dictum tincidunt diam. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est.", date: .now),
    NotesTodo(id: .init(), text: "Cras pede libero, dapibus nec, pretium sit amet, tempor quis. Ut tempus purus at lorem. Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac, erat. Maecenas libero. Pellentesque sapien. Phasellus rhoncus. Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Ut tempus purus at lorem. Nam sed tellus id magna elementum tincidunt. Duis pulvinar. Aliquam in lorem sit amet leo accumsan lacinia.", date: .now),
    NotesTodo(id: .init(), text: "Suspendisse sagittis ultrices augue. Fusce aliquam vestibulum ipsum. Curabitur sagittis hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Maecenas libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam rhoncus aliquam metus. Duis sapien nunc, commodo et, interdum suscipit, sollicitudin et, dolor. Mauris tincidunt sem sed arcu. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Integer malesuada. Vivamus luctus egestas leo. Nulla quis diam.", date: .now),
    NotesTodo(id: .init(), text: "Pellentesque arcu. Praesent in mauris eu tortor porttitor accumsan. Maecenas ipsum velit, consectetuer eu lobortis ut, dictum at dui. Aliquam erat volutpat. Aenean fermentum risus id tortor. Aenean placerat. Nam quis nulla. Praesent dapibus. Nullam dapibus fermentum ipsum. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Nulla non lectus sed nisl molestie malesuada. Quisque porta. Curabitur bibendum justo non orci.", date: .now),
    NotesTodo(id: .init(), text: "Integer malesuada. Nam quis nulla. Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Integer vulputate sem a nibh rutrum consequat. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Mauris dictum facilisis augue. Pellentesque pretium lectus id turpis. Maecenas aliquet accumsan leo. Pellentesque sapien. Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac, erat. Quisque porta. Etiam bibendum elit eget erat. Proin in tellus sit amet nibh dignissim sagittis.", date: .now),
  ]
}
