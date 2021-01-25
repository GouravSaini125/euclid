const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "euclid": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://zlu3uecjkzdutggxyhquitub3i.appsync-api.ap-south-1.amazonaws.com/graphql",
                    "region": "ap-south-1",
                    "authorizationType": "API_KEY",
                    "apiKey": XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                }
            }
        }
    }
}''';