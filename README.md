# Performace Tests framework

Performance testing framework is created to define performance tests in YAML format and to run them using taurus.

Please refer to the official [User Manual](https://gettaurus.org/docs/Index/).


### Jmeter Report generation

To generate a jMeter dashboard run the following command:

```sh
jmeter -g artifacts/trace.jtl -o artifacts/report
```

The report will be created in *artifacts/report* folder.


**PLEASE NOTE:** all *trace.jtl* logs are stored after each run. Please ensure that you are using a correct file. The file format is *trace-{number}.jtl* 

### Blazemeter report

The blazemeter reporter uploads all tests stats into BlazeMeter.com service

```sh
bzt execute.yml -o reporting.2.module=blazemeter
```

*More info:* 
https://gettaurus.org/docs/BlazemeterReporter/


### Jenkins plugins
- Credentials (https://plugins.jenkins.io/credentials-binding/)
- HTML Publisher (https://plugins.jenkins.io/htmlpublisher/)
- Performance (https://plugins.jenkins.io/performance/)

### Jmeter Remote 

```
docker run -it --rm -p 1099:1099 jmeter 
```

*More info:*
https://jmeter.apache.org/usermanual/remote-test.html

### Distributed execution

```
bzt execute.yml -o execution.0.scenario=quick-test -o execution.0.distributed.0=127.0.0.1
```

*More info:*
https://jmeter.apache.org/usermanual/jmeter_distributed_testing_step_by_step.pdf
https://gettaurus.org/docs/JMeter/#Run-JMeter-in-Distributed-Mode

### Resource monitoring

https://gettaurus.org/docs/Monitoring/