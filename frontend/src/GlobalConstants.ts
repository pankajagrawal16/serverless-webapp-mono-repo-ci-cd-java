type Config = {
    FIND_IMAGE: string,
    UPLOAD_URL: string,
}

export const GLOBAL_CONSTANTS = new Map<string, Config>();

GLOBAL_CONSTANTS.set('JAVA', {
        'FIND_IMAGE': `https://facerecogapp.azurewebsites.net/api/find-person?code=k31usW1BlCxAhx9juhjagRnDhthqBM2yP80ZUykfoRy2AzFuC5XJrA==`,
        'UPLOAD_URL': `https://facerecogapp.azurewebsites.net/api/upload-url?code=ceMGuixrDAgPiI-OOnWRXm1Nc_44NeIaG257QAJ5tmsTAzFuLHUKkQ==`,
    });

GLOBAL_CONSTANTS.set('PYTHON', {
    'FIND_IMAGE': `https://facerecogapp.azurewebsites.net/api/find-person?code=k31usW1BlCxAhx9juhjagRnDhthqBM2yP80ZUykfoRy2AzFuC5XJrA==`,
    'UPLOAD_URL': `https://facerecogapp.azurewebsites.net/api/upload-url?code=ceMGuixrDAgPiI-OOnWRXm1Nc_44NeIaG257QAJ5tmsTAzFuLHUKkQ==`,
});

export const Links_List = [
    {label: 'Source code for the project', link: 'https://github.com/aws-samples/serverless-webapp-mono-repo-ci-cd-java'},
    {label: 'Architecture diagram', link: '/serverless-webapp-mono-repo-ci-cd-java.png'},
    {label: 'Amazon Rekognition', link: 'https://aws.amazon.com/rekognition/'},
    {label: 'AWS Serverless Application Model', link: 'https://aws.amazon.com/serverless/sam/'},
    {label: 'AWS Cloud Development Kit (AWS CDK)', link: 'https://docs.aws.amazon.com/cdk/latest/guide/work-with-cdk-java.html'},
    {label: 'Learn more about AWS developer tools services?', link: 'https://aws.amazon.com/products/developer-tools/'},
    {label: 'Connect with me @agrawalpankaj16', link: 'https://twitter.com/agrawalpankaj16'},
];
