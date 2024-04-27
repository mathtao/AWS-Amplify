//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import FaceLiveness
import Amplify

class ExampleLivenessViewModel: ObservableObject {
    @Published var presentationState = PresentationState.liveness
    let sessionID: String

    init(sessionID: String) {
        self.sessionID = sessionID
    }

    func fetchLivenessResult() async throws -> ExampleLivenessViewModel.Result {
        let request = RESTRequest(
            apiName: "liveness",
            path: "/liveness/\(sessionID)"
        )

        let data = try await Amplify.API.get(request: request)
        let result = try JSONDecoder().decode(LivenessResult.self, from: data)
        let score = ExampleLivenessViewModel.Result(livenessResult: result)
        return score
    }

    enum PresentationState: Equatable {
        case liveness, result, error(FaceLivenessDetectionError)
    }
}


extension ExampleLivenessViewModel {
    struct Result {
        let text: String
        let value: String
        let auditImage: Data?

        init(livenessResult: LivenessResult) {
            guard livenessResult.confidenceScore > 0 else {
                text = ""
                value = ""
                auditImage = nil
                return
            }

            let truncated = String(format: "%.4f", livenessResult.confidenceScore)
            value = truncated
            if livenessResult.isLive {
                text = "Check successful"
            } else {
                text = "Check unsuccessful"
            }
            auditImage = livenessResult.auditImageBytes.flatMap{
                Data(base64Encoded: $0)
            }
        }
    }

    struct Score {
        let resultText: String
        let value: String

        init(value: Double, resultText: String){
            self.resultText = resultText
            self.value = String(format: "%.4f", value)
        }
    }
}
