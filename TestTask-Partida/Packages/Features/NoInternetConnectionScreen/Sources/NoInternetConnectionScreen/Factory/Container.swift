import Factory

extension Container {
    public var noInternetConnectionViewModel: ParameterFactory<NoInternetConnectionViewModel.Args, NoInternetConnectionViewModel> {
        ParameterFactory(self) { args in
            NoInternetConnectionViewModel(args: args)
        }
    }
}
