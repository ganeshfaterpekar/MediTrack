protocol AuthConfig {
    func getUser() -> String
    func getApiKey() -> String
}


class AuthConfigService: AuthConfig {
    func getUser() -> String {
        return "healthengine-mobile-test-2026"
    }
    
    func getApiKey() -> String {
        return "test-user"
    }
    
}
