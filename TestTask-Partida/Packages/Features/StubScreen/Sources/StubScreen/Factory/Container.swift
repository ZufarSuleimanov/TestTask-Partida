import Factory

extension Container {
    public var stubViewModel: Factory<StubViewModel> {
        Factory(self) { StubViewModel() }
    }
}
