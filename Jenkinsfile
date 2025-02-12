pipeline {
    agent any

    stages {
        stage('Git Checkout stage') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/prathyusha573/terraform-jenkins.git']])
            }
        }
        stage('sonarscanner') {
            steps {
                   tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                   echo 'No warnings'
                   }
}

        stage('Terraform INIT') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform plan') {
            steps {
                withCredentials([
                    azureServicePrincipal(
                        credentialsId: 'AZURE-SERVICE-PRINCIPAL',
                        subscriptionIdVariable: 'SUB_ID',
                        clientIdVariable: 'CLIENT_ID',
                        clientSecretVariable: 'CLIENT_SECRET',
                        tenantIdVariable: 'TENANT_ID'
                    )
                ]) {
                    sh '''
                        terraform plan -var "subscription_id=$SUB_ID" \
                        -var "tenant_id=$TENANT_ID" \
                        -var "client_secret=$CLIENT_SECRET" \
                        -var "client_id=$CLIENT_ID"
                    '''
                }
            }
        }
        stage('Terraform apply') {
            steps {
                withCredentials([
                    azureServicePrincipal(
                        credentialsId: 'AZURE-SERVICE-PRINCIPAL',
                        subscriptionIdVariable: 'SUB_ID',
                        clientIdVariable: 'CLIENT_ID',
                        clientSecretVariable: 'CLIENT_SECRET',
                        tenantIdVariable: 'TENANT_ID'
                    )
                ]) {
                    sh '''
                        terraform apply -auto-approve \
                        -var "subscription_id=$SUB_ID" \
                        -var "tenant_id=$TENANT_ID" \
                        -var "client_secret=$CLIENT_SECRET" \
                         -var "client_id=$CLIENT_ID"
                    '''

                }
            }
        }
        
        
    }
}
