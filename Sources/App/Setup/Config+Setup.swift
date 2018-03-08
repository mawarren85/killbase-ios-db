import FluentProvider
import PostgreSQLProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)

        Node.fuzzy = [Row.self, JSON.self, Node.self]

        try setupProviders()
        try setupPreparations()
    }

    /// Configure providers

    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
        try addProvider(PostgreSQLProvider.Provider.self)
    }

    /// Add all models that should have their
    /// schemas prepared before the app boots

    private func setupPreparations() throws {
        preparations.append(User.self)
        preparations.append(Reminder.self)
        preparations.append(Category.self)
        preparations.append(Pivot<Reminder, Category>.self)
        preparations.append(Assassin.self)
        preparations.append(Codename.self)
        preparations.append(Client.self)
        preparations.append(Target.self)
        preparations.append(Contract.self)
        preparations.append(Pivot<Assassin, Contract>.self)
    }
}
