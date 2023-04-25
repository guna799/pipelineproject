pipeline {
    agent any
    parameters {
          choice(
            name: 'Startservice',
            choices: ['zookeeper', 'kafka', 'Docker'],
            description: 'To start the service'
        )
        choice(
            name: 'StatusCheck',
            choices: ['zookeeper', 'kafka', 'Docker'],
            description: 'Choose the status check to perform'
        )
    }
        
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Zookeeper start') {
            when {
                expression { params.Startservice == 'zookeeper' }
            }
            steps {
                script {
                    sh 'sudo systemctl start zookeeper.service'
                }
            }
        }
        stage('Kafka start') {
            when {
                expression { params.Startservice == 'kafka' }
            }
            steps {
                script {
                    sh 'sudo systemctl start kafka.service'
                }
            } 
        }
        stage('Docker start ') {
            when {
                expression { params.Startservice == 'Docker' }
            }
            steps {
                script {
                    sh 'sudo systemctl start docker'
                }
            }
        }
        stage('Zookeeper status') {
            when {
                expression { params.StatusCheck == 'zookeeper' }
            }
            steps {
                script {
                    sh 'sudo systemctl status zookeeper.service'
                }
            }
        }
        stage('Kafka status') {
            when {
                expression { params.StatusCheck == 'kafka' }
            }
            steps {
                script {
                    sh 'sudo systemctl status kafka.service'
                }
            } 
        }
        stage('Docker status ') {
            when {
                expression { params.StatusCheck == 'Docker' }
            }
            steps {
                script {
                    sh 'sudo systemctl status docker'
                }
            }
        }
    }
}
