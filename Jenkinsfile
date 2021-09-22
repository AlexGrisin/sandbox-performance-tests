def podLabel = UUID.randomUUID().toString()
def jmeterVersion = 5.3
def artifactsDirectory = 'artifacts'

String bztRepo = "agrisin/bzt"
String bztVersion = 'latest'

properties([
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '5')),
        parameters([
                choice(choices: ['search', 'home'], description: '', name: 'scenario'),
                choice(choices: ['10', '100', '1000'], description: '', name: 'iterations')
        ])
])

podTemplate(
        label: podLabel,
        containers: [
                containerTemplate(
                        name: 'bzt',
                        image: "$bztRepo:$bztVersion",
                        alwaysPullImage: true,
                        ttyEnabled: true,
                        command: 'cat',
                        workingDir: '/home/jenkins/agent'
                )
        ]
)

{
    node(podLabel) {
        try
        {
            stage('checkout') {
                checkout scm
            }

            container('bzt') {
                stage('run tests') {
                    sh "bzt execute.yml \
                       -o modules.jmeter.version=${jmeterVersion} \
                       -o settings.artifacts-dir=${artifactsDirectory} \
                       -o execution.0.scenario=${params.scenario} \
                       -o execution.0.write-xml-jtl=full \
                       -o execution.0.iterations=${params.iterations} "
                }
            }

            container('bzt') {
                stage('publish performance trends') {
                    perfReport(compareBuildPrevious: true,
                               modeOfThreshold: true,
                               relativeUnstableThresholdPositive: -1,
                               sourceDataFiles: 'stats.xml')
                }
            }

            container('bzt') {
                stage('jmeter report') {
                    sh "/root/.bzt/jmeter-taurus/${jmeterVersion}/bin/jmeter -g ${artifactsDirectory}/trace.jtl -o report"
                    sh "tar czf report.tar.gz report/"
                    sh "tar czf artifacts.tar.gz ${artifactsDirectory}/"
                }
            }
        }
        catch (any)
        {
            currentBuild.result = 'FAILURE'
            throw any
        }
        finally
        {
            if (currentBuild.result == null)
            {
                currentBuild.result = 'SUCCESS'
            }
            archiveArtifacts 'artifacts.tar.gz'
            archiveArtifacts 'report.tar.gz'
            publishHTML(target: [
                    allowMissing         : false,
                    alwaysLinkToLastBuild: true,
                    keepAll              : true,
                    reportDir            : 'report',
                    reportFiles          : 'index.html',
                    reportName           : "Performance Report"
            ])
        }
    }
}