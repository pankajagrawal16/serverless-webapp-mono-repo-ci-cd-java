type Config = {
    FIND_IMAGE: string,
    UPLOAD_URL: string,
}

export const GLOBAL_CONSTANTS = new Map<string, Config>();

GLOBAL_CONSTANTS.set('JAVA', {
        'FIND_IMAGE': `https://api.pankaagr.cloud/face/find-person?code=2eaa28d7ea62477291070423ee1244ce`,
        'UPLOAD_URL': `https://api.pankaagr.cloud/face/upload-url?code=2eaa28d7ea62477291070423ee1244ce`,
    });

GLOBAL_CONSTANTS.set('PYTHON', {
    'FIND_IMAGE': `https://api.pankaagr.cloud/face/find-person?code=2eaa28d7ea62477291070423ee1244ce`,
    'UPLOAD_URL': `https://api.pankaagr.cloud/face/upload-url?code=2eaa28d7ea62477291070423ee1244ce`,
});

export const Links_List = [
    {label: 'Source code for the project', link: 'https://github.com/pankajagrawal16/serverless-webapp-mono-repo-ci-cd-java'},
   // {label: 'Architecture diagram', link: '/serverless-webapp-mono-repo-ci-cd-java.png'},
  //  {label: 'Amazon Rekognition', link: 'https://aws.amazon.com/rekognition/'},
  //  {label: 'AWS Serverless Application Model', link: 'https://aws.amazon.com/serverless/sam/'},
   // {label: 'AWS Cloud Development Kit (AWS CDK)', link: 'https://docs.aws.amazon.com/cdk/latest/guide/work-with-cdk-java.html'},
   // {label: 'Learn more about AWS developer tools services?', link: 'https://aws.amazon.com/products/developer-tools/'},
    {label: 'Connect with me @agrawalpankaj16', link: 'https://twitter.com/agrawalpankaj16'},
];
