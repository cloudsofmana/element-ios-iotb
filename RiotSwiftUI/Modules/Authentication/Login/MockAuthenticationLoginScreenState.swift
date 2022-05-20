// 
// Copyright 2021 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import SwiftUI

/// Using an enum for the screen allows you define the different state cases with
/// the relevant associated data for each case.
enum MockAuthenticationLoginScreenState: MockScreenState, CaseIterable {
    // A case for each state you want to represent
    // with specific, minimal associated data that will allow you
    // mock that screen.
    case matrixDotOrg
    case passwordOnly
    case passwordWithCredentials
    case ssoOnly

    /// The associated screen
    var screenType: Any.Type {
        AuthenticationLoginScreen.self
    }
    
    /// Generate the view struct for the screen state.
    var screenView: ([Any], AnyView)  {
        let viewModel: AuthenticationLoginViewModel
        switch self {
        case .matrixDotOrg:
            viewModel = AuthenticationLoginViewModel(homeserverAddress: "https://matrix.org", ssoIdentityProviders: [
                SSOIdentityProvider(id: "1", name: "Apple", brand: "apple", iconURL: nil),
                SSOIdentityProvider(id: "2", name: "Facebook", brand: "facebook", iconURL: nil),
                SSOIdentityProvider(id: "3", name: "GitHub", brand: "github", iconURL: nil),
                SSOIdentityProvider(id: "4", name: "GitLab", brand: "gitlab", iconURL: nil),
                SSOIdentityProvider(id: "5", name: "Google", brand: "google", iconURL: nil)
            ])
        case .passwordOnly:
            viewModel = AuthenticationLoginViewModel(homeserverAddress: "https://example.com", ssoIdentityProviders: [])
        case .passwordWithCredentials:
            viewModel = AuthenticationLoginViewModel(homeserverAddress: "https://example.com", ssoIdentityProviders: [])
            viewModel.context.username = "alice"
            viewModel.context.password = "password"
        case .ssoOnly:
            viewModel = AuthenticationLoginViewModel(homeserverAddress: "https://company.com",
                                                     showLoginForm: false,
                                                     ssoIdentityProviders: [SSOIdentityProvider(id: "test", name: "SAML", brand: nil, iconURL: nil)])
        }
        
        
        // can simulate service and viewModel actions here if needs be.
        
        return (
            [viewModel], AnyView(AuthenticationLoginScreen(viewModel: viewModel.context))
        )
    }
}
