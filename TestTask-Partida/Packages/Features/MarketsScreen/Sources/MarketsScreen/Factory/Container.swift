import Factory

extension Container {
    public var marketsViewModel: ParameterFactory<MarketsViewModel.Args, MarketsViewModel> {
        ParameterFactory(self) { args in
            MarketsViewModel(args: args)
        }
    }
}

